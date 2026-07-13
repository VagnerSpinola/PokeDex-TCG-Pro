from fastapi import APIRouter, HTTPException, status

from app.dependencies import CurrentUser, DbSession
from app.schemas.auth import LoginRequest, RefreshRequest, RegisterRequest, TokenPair, UserOut
from app.services import auth_service

router = APIRouter(prefix="/auth", tags=["auth"])


@router.post("/register", response_model=UserOut, status_code=status.HTTP_201_CREATED)
async def register(body: RegisterRequest, db: DbSession) -> UserOut:
    try:
        user = await auth_service.register_user(db, body.email, body.password)
    except auth_service.EmailTakenError:
        raise HTTPException(status.HTTP_409_CONFLICT, "Email already registered") from None
    return UserOut.model_validate(user)


@router.post("/login", response_model=TokenPair)
async def login(body: LoginRequest, db: DbSession) -> TokenPair:
    try:
        return await auth_service.login_user(db, body.email, body.password)
    except auth_service.AuthError:
        raise HTTPException(status.HTTP_401_UNAUTHORIZED, "Invalid email or password") from None


@router.post("/refresh", response_model=TokenPair)
async def refresh(body: RefreshRequest, db: DbSession) -> TokenPair:
    try:
        return await auth_service.refresh_tokens(db, body.refresh_token)
    except auth_service.AuthError:
        raise HTTPException(status.HTTP_401_UNAUTHORIZED, "Invalid or expired token") from None


@router.get("/me", response_model=UserOut)
async def me(user: CurrentUser) -> UserOut:
    return UserOut.model_validate(user)
