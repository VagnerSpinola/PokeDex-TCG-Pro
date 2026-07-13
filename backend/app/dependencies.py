from typing import Annotated

from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from sqlalchemy import select
from sqlalchemy.exc import IntegrityError
from sqlalchemy.ext.asyncio import AsyncSession

from app.database import get_db
from app.models import User
from app.services import auth_service

bearer_scheme = HTTPBearer(auto_error=False)


async def get_current_user(
    db: Annotated[AsyncSession, Depends(get_db)],
    credentials: Annotated[HTTPAuthorizationCredentials | None, Depends(bearer_scheme)],
) -> User:
    if credentials is None:
        raise HTTPException(status.HTTP_401_UNAUTHORIZED, "Not authenticated")
    try:
        return await auth_service.get_user_by_token(db, credentials.credentials)
    except auth_service.AuthError:
        raise HTTPException(status.HTTP_401_UNAUTHORIZED, "Invalid or expired token") from None


# Auth is temporarily out of the app flow (user decision, 2026-07-13): requests
# without a token act as a shared local default user instead of getting a 401.
# A valid bearer token still resolves to its own user; an invalid one still 401s.
DEFAULT_USER_EMAIL = "local@app"


async def get_current_user_or_default(
    db: Annotated[AsyncSession, Depends(get_db)],
    credentials: Annotated[HTTPAuthorizationCredentials | None, Depends(bearer_scheme)],
) -> User:
    if credentials is not None:
        try:
            return await auth_service.get_user_by_token(db, credentials.credentials)
        except auth_service.AuthError:
            raise HTTPException(
                status.HTTP_401_UNAUTHORIZED, "Invalid or expired token"
            ) from None

    user = await db.scalar(select(User).where(User.email == DEFAULT_USER_EMAIL))
    if user is None:
        user = User(email=DEFAULT_USER_EMAIL, hashed_password=None)
        db.add(user)
        try:
            await db.commit()
        except IntegrityError:  # concurrent first request already created it
            await db.rollback()
            user = await db.scalar(select(User).where(User.email == DEFAULT_USER_EMAIL))
            assert user is not None
        else:
            await db.refresh(user)
    return user


CurrentUser = Annotated[User, Depends(get_current_user)]
CurrentUserOrDefault = Annotated[User, Depends(get_current_user_or_default)]
DbSession = Annotated[AsyncSession, Depends(get_db)]
