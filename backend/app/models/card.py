from sqlalchemy import ForeignKey, String, Text
from sqlalchemy.orm import Mapped, mapped_column, relationship
from sqlalchemy.types import JSON

from app.models.base import Base, TimestampMixin
from app.models.set import Set


class Card(Base, TimestampMixin):
    """A single card printing. Primary key is the external API id (e.g. 'sv1-25')."""

    __tablename__ = "cards"

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    name: Mapped[str] = mapped_column(String(255), index=True, nullable=False)
    set_id: Mapped[str] = mapped_column(
        ForeignKey("sets.id", ondelete="CASCADE"), index=True, nullable=False
    )
    number: Mapped[str | None] = mapped_column(String(32))
    supertype: Mapped[str | None] = mapped_column(String(32), index=True)
    subtypes: Mapped[list | None] = mapped_column(JSON)
    types: Mapped[list | None] = mapped_column(JSON)
    rarity: Mapped[str | None] = mapped_column(String(64), index=True)
    hp: Mapped[int | None]
    artist: Mapped[str | None] = mapped_column(String(255))
    image_small_url: Mapped[str | None] = mapped_column(String(512))
    image_large_url: Mapped[str | None] = mapped_column(String(512))
    flavor_text: Mapped[str | None] = mapped_column(Text)

    set: Mapped[Set] = relationship(lazy="joined")
