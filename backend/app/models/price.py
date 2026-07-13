from datetime import date as date_type
from decimal import Decimal

from sqlalchemy import Date, ForeignKey, Index, Numeric, String, UniqueConstraint
from sqlalchemy.orm import Mapped, mapped_column

from app.models.base import Base, TimestampMixin


class Price(Base, TimestampMixin):
    """Daily market price snapshot per card/source/variant.

    AGENTS.md §5 mandates uniqueness per (card_id, source, date); `variant` is
    part of the key because TCGplayer publishes several printings of the same
    card (normal, holofoil, ...) on the same day. Cardmarket uses 'default'.
    """

    __tablename__ = "prices"
    __table_args__ = (
        UniqueConstraint(
            "card_id", "source", "variant", "date", name="uq_prices_card_source_variant_date"
        ),
        Index("ix_prices_card_date", "card_id", "date"),
    )

    id: Mapped[int] = mapped_column(primary_key=True)
    card_id: Mapped[str] = mapped_column(
        ForeignKey("cards.id", ondelete="CASCADE"), index=True, nullable=False
    )
    source: Mapped[str] = mapped_column(String(32), nullable=False)  # tcgplayer | cardmarket
    variant: Mapped[str] = mapped_column(String(64), nullable=False, server_default="default")
    date: Mapped[date_type] = mapped_column(Date, nullable=False)
    currency: Mapped[str] = mapped_column(String(8), nullable=False)  # USD | EUR
    low: Mapped[Decimal | None] = mapped_column(Numeric(12, 2))
    mid: Mapped[Decimal | None] = mapped_column(Numeric(12, 2))
    high: Mapped[Decimal | None] = mapped_column(Numeric(12, 2))
    market: Mapped[Decimal | None] = mapped_column(Numeric(12, 2))
