from sqlalchemy import String
from sqlalchemy.orm import Mapped, mapped_column

from app.models.base import Base, TimestampMixin


class User(Base, TimestampMixin):
    __tablename__ = "users"

    id: Mapped[int] = mapped_column(primary_key=True)
    email: Mapped[str] = mapped_column(String(320), unique=True, index=True, nullable=False)
    # Nullable so future OAuth-only accounts don't need a local password.
    hashed_password: Mapped[str | None] = mapped_column(String(255))
    role: Mapped[str] = mapped_column(String(32), nullable=False, server_default="user")
    oauth_provider: Mapped[str | None] = mapped_column(String(32))
    is_verified: Mapped[bool] = mapped_column(nullable=False, server_default="false")
