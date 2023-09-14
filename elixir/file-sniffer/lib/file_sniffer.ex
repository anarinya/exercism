defmodule FileSniffer do
  def type_from_extension("exe" = _ext), do: "application/octet-stream"
  def type_from_extension("bmp" = _ext), do: "image/bmp"
  def type_from_extension("png" = _ext), do: "image/png"
  def type_from_extension("jpg" = _ext), do: "image/jpg"
  def type_from_extension("gif" = _ext), do: "image/gif"
  def type_from_extension(_ext), do: nil

  def type_from_binary(<<0x7F, 0x45, 0x4C, 0x46>> <> _rest), do: "application/octet-stream"
  def type_from_binary(<<0x42, 0x4D>> <> _rest), do: "image/bmp"
  def type_from_binary(<<0xFF, 0xD8, 0xFF>> <> _rest), do: "image/jpg"
  def type_from_binary(<<0x47, 0x49, 0x46>> <> _rest), do: "image/gif"

  def type_from_binary(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A>> <> _rest),
    do: "image/png"

  def type_from_binary(_), do: nil

  def verify(file_binary, extension) do
    binary_type = type_from_binary(file_binary)
    verify_types(binary_type, binary_type == type_from_extension(extension))
  end

  defp verify_types(nil, _), do: type_error()
  defp verify_types(type, true), do: {:ok, type}
  defp verify_types(_type, false), do: type_error()

  defp type_error, do: {:error, "Warning, file format and file extension do not match."}
end
