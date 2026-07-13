from datetime import UTC, datetime, timedelta
from typing import Any, Literal

from jose import JWTError, jwt
from passlib.context import CryptContext

from app.config import get_settings

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

TokenType = Literal["access", "refresh"]


def hash_password(password: str) -> str:
    return pwd_context.hash(password)


def verify_password(plain: str, hashed: str) -> bool:
    return pwd_context.verify(plain, hashed)


def create_token(user_id: int, token_type: TokenType) -> str:
    settings = get_settings()
    if token_type == "access":
        expires = timedelta(minutes=settings.jwt_access_ttl_minutes)
    else:
        expires = timedelta(days=settings.jwt_refresh_ttl_days)
    payload = {
        "sub": str(user_id),
        "type": token_type,
        "exp": datetime.now(UTC) + expires,
        "iat": datetime.now(UTC),
    }
    return jwt.encode(payload, settings.jwt_secret_key, algorithm=settings.jwt_algorithm)


def decode_token(token: str, expected_type: TokenType) -> dict[str, Any] | None:
    """Returns the payload, or None if invalid/expired/wrong type."""
    settings = get_settings()
    try:
        payload = jwt.decode(token, settings.jwt_secret_key, algorithms=[settings.jwt_algorithm])
    except JWTError:
        return None
    if payload.get("type") != expected_type:
        return None
    return payload
