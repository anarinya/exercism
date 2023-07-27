defmodule HighSchoolSweetheart do
  @spec first_letter(name :: String.t()) :: String.t()
  def first_letter(name), do: name |> String.trim() |> String.first()

  @spec initial(name :: String.t()) :: String.t()
  def initial(name), do: name |> first_letter |> String.upcase() |> Kernel.<>(".")

  @spec initials(full_name :: String.t()) :: String.t()
  def initials(full_name),
    do: full_name |> String.split() |> Enum.map(&initial/1) |> Enum.join(" ")

  @spec pair(full_name1 :: String.t(), full_name2 :: String.t()) :: String.t()
  def pair(full_name1, full_name2) do
    name_pairs =
      [full_name1, full_name2]
      |> Enum.map(&initials/1)
      |> Enum.join("  +  ")

    """
         ******       ******
       **      **   **      **
     **         ** **         **
    **            *            **
    **                         **
    **     #{name_pairs}     **
     **                       **
       **                   **
         **               **
           **           **
             **       **
               **   **
                 ***
                  *
    """
  end
end
