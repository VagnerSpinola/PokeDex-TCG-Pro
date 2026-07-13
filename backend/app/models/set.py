from datetime import date

from sqlalchemy import Date, String
from sqlalchemy.orm import Mapped, mapped_column

from app.models.base import Base, TimestampMixin


class Set(Base, TimestampMixin):
    """A TCG expansion set. Primary key is the external Pokémon TCG API id (e.g. 'sv1')."""

    __tablename__ = "sets"

    id: Mapped[str] = mapped_column(String(32), primary_key=True)
    name: Mapped[str] = mapped_column(String(255), index=True, nullable=False)
    series: Mapped[str | None] = mapped_column(String(255))
    printed_total: Mapped[int | None]
    total: Mapped[int | None]
    release_date: Mapped[date | None] = mapped_column(Date)
    symbol_url: Mapped[str | None] = mapped_column(String(512))
    logo_url: Mapped[str | None] = mapped_column(String(512))
