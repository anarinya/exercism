defmodule LogParser do
  # returns true or false if a log starts with [DEBUG], [ERROR], [WARNING], or [INFO]
  def valid_line?(line), do: String.match?(line, ~r/^\[(DEBUG|ERROR|WARNING|INFO)\]/)

  # splits lines based on any combination of <> with ~*=- characters in between
  def split_line(line), do: String.split(line, ~r/<[\~\*\=-]*>/)

  # removes text that matches "end-of-line123" with any numbers, case insensitive
  def remove_artifacts(line), do: String.replace(line, ~r/end-of-line\d+/i, "")

  # for logs with User Username text in the log, appends with [USER] Username
  def tag_with_user_name(line) do
    case Regex.run(~r/User\s+([^[:space:]]+)/, line) do
      [_, name] when is_binary(name) ->
        "[USER] #{name} " <> line

      _ ->
        line
    end
  end
end
