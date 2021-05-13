defmodule TbjBudgeting.Calculations do
  @moduledoc """
  The Calculations context.
  """
  alias TbjBudgeting.Repo
  alias TbjBudgeting.Calculations.Calculation

  @doc """
  Get all Calculations
  """
  def list_all(), do: Repo.all(Calculation)

  @doc """
  Creates a calculation.
  """
  def create(changeset), do: Repo.insert!(changeset)

  @doc """
  Deletes a calculation.
  """
  def delete(changeset), do: Repo.delete!(changeset)
end
