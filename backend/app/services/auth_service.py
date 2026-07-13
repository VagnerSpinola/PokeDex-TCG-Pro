from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models import User
from app.schemas.auth import TokenPair
from app.security import create_token, decode_token, hash_password, verify_password


class AuthError(Exception):
    """Raised for invalid credentials / tokens. Routers map it to HTTP 401."""


class EmailTakenError(Exception):
    """Raised when registering an email that already exists. Mapped to HTTP 409."""


def _token_pair(user_id: int) -> TokenPair:
    return TokenPair(
        access_token=create_token(user_id, "access"),
        refresh_token=create_token(user_id, "refresh"),
    )


async def register_user(db: AsyncSession, email: str, password: str) -> User:
    existing = await db.scalar(select(User).where(User.email == email.lower()))
    if existing is not None:
        raise EmailTakenError
    user = User(email=email.lower(), hashed_password=hash_password(password))
    db.add(user)
    await db.commit()
    await db.refresh(user)
    return user


async def login_user(db: AsyncSession, email: str, password: str) -> TokenPair:
    user = await db.scalar(select(User).where(User.email == email.lower()))
    if user is None or user.hashed_password is None:
        raise AuthError
    if not verify_password(password, user.hashed_password):
        raise AuthError
    return _token_pair(user.id)


async def refresh_tokens(db: AsyncSession, refresh_token: str) -> TokenPair:
    payload = decode_token(refresh_token, expected_type="refresh")
    if payload is None:
        raise AuthError
    user = await db.get(User, int(payload["sub"]))
    if user is None:
        raise AuthError
    return _token_pair(user.id)


async def get_user_by_token(db: AsyncSession, access_token: str) -> User:
    payload = decode_token(access_token, expected_type="access")
    if payload is None:
        raise AuthError
    user = await db.get(User, int(payload["sub"]))
    if user is None:
        raise AuthError
    return user
