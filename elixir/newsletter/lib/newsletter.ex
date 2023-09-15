defmodule Newsletter do
  @spec read_emails(String.t()) :: [String.t()]
  def read_emails(path) do
    emails = File.read(path)

    case emails do
      {:ok, list} -> String.split(list, "\n", trim: true)
      _ -> []
    end
  end

  @spec open_log(String.t()) :: PID.t()
  def open_log(path), do: File.open!(path, [:write])

  @spec log_sent_email(PID.t(), String.t()) :: :ok
  def log_sent_email(log_file_pid, email), do: IO.puts(log_file_pid, email)

  @spec close_log(PID.t()) :: :ok
  def close_log(pid), do: File.close(pid)

  @spec send_newsletter(String.t(), String.t(), fun()) :: :ok
  def send_newsletter(emails_path, log_path, send_fun) do
    log_file_pid = open_log(log_path)

    read_emails(emails_path)
    |> Enum.each(fn email ->
      case send_fun.(email) do
        :ok -> log_sent_email(log_file_pid, email)
        _ -> :error
      end
    end)

    close_log(log_file_pid)
  end
end
