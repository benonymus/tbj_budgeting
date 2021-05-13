defmodule TbjBudgeting.Calculations.Calculation do
  use Ecto.Schema
  import Ecto.Changeset
  alias TbjBudgeting.Calculations.{Calculation, Value}

  schema "calculations" do
    field(:title, :string)
    field(:result, :integer, default: 0)
    embeds_many(:pluses, Value)
    embeds_many(:minuses, Value)

    timestamps()
  end

  @doc false
  def changeset(%Calculation{} = calculation, attrs) do
    calculation
    |> cast(attrs, [:result, :title])
    |> cast_embed(:pluses, with: &Value.changeset/2)
    |> cast_embed(:minuses, with: &Value.changeset/2)
    |> calculate_result()
  end

  defp calculate_result(changeset) do
    pluses =
      get_field(changeset, :pluses)
      |> sum_values

    minuses =
      get_field(changeset, :minuses)
      |> sum_values

    result = abs(pluses) - abs(minuses)

    force_change(changeset, :result, result)
  end

  defp sum_values(values) do
    values
    |> Enum.map(fn x -> x.value end)
    |> Enum.sum()
  end
end

defmodule TbjBudgeting.Calculations.Value do
  use Ecto.Schema
  import Ecto.Changeset
  alias TbjBudgeting.Calculations.Value

  @primary_key false

  embedded_schema do
    field(:title, :string)
    field(:value, :integer, default: 0)
  end

  def changeset(schema, params) do
    schema
    |> cast(params, [:value, :title])
  end

  def add_value(changeset, key) do
    value_changeset =
      %Value{}
      |> Value.changeset(%{})

    values =
      changeset
      |> get_field(key)
      |> List.insert_at(-1, value_changeset)

    put_embed(changeset, key, values)
  end
end
