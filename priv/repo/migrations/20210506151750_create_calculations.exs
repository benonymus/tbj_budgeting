defmodule TbjBudgeting.Repo.Migrations.CreateCalculations do
  use Ecto.Migration

  def change do
    create table(:calculations) do
      add(:title, :string)
      add(:result, :integer)
      add(:pluses, {:array, :map}, default: [])
      add(:minuses, {:array, :map}, default: [])

      timestamps()
    end
  end
end
