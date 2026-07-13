import enum

from sqlalchemy import Enum, ForeignKey, String, UniqueConstraint
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.models.base import Base, TimestampMixin
from app.models.card import Card


class CardCondition(str, enum.Enum):
    mint = "mint"
    near_mint = "near_mint"
    excellent = "excellent"
    good = "good"
    played = "played"
    poor = "poor"


class CollectionItem(Base, TimestampMixin):
    __tablename__ = "collection_items"
    __table_args__ = (
        UniqueConstraint("user_id", "card_id", "condition", name="uq_collection_user_card_cond"),
    )

    id: Mapped[int] = mapped_column(primary_key=True)
    user_id: Mapped[int] = mapped_column(
        ForeignKey("users.id", ondelete="CASCADE"), index=True, nullable=False
    )
    card_id: Mapped[str] = mapped_column(
        ForeignKey("cards.id", ondelete="CASCADE"), index=True, nullable=False
    )
    quantity: Mapped[int] = mapped_column(nullable=False, server_default="1")
    condition: Mapped[CardCondition] = mapped_column(
        Enum(CardCondition, name="card_condition", values_callable=lambda e: [m.value for m in e]),
        nullable=False,
        server_default=CardCondition.near_mint.value,
    )
    notes: Mapped[str | None] = mapped_column(String(1000))

    card: Mapped[Card] = relationship(lazy="joined")
