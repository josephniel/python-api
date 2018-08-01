"""Add users table

Revision ID: 5adc01b5fb9d
Revises: 
Create Date: 2018-08-01 05:03:57.170602

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '5adc01b5fb9d'
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('users',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('name', sa.String(), nullable=True),
    sa.PrimaryKeyConstraint('id')
    )
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('users')
    # ### end Alembic commands ###
