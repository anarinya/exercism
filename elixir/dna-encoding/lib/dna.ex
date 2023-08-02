defmodule DNA do
  @spec encode_nucleotide(char) :: integer
  def encode_nucleotide(?\s), do: 0b0000
  def encode_nucleotide(?A), do: 0b0001
  def encode_nucleotide(?C), do: 0b0010
  def encode_nucleotide(?G), do: 0b0100
  def encode_nucleotide(?T), do: 0b1000

  @spec decode_nucleotide(integer) :: char
  def decode_nucleotide(0b0000), do: ?\s
  def decode_nucleotide(0b0001), do: ?A
  def decode_nucleotide(0b0010), do: ?C
  def decode_nucleotide(0b0100), do: ?G
  def decode_nucleotide(0b1000), do: ?T

  @spec encode(list(char)) :: bitstring
  def encode(dna), do: do_encode(dna, <<>>)

  @spec do_encode(list(char), bitstring) :: bitstring
  defp do_encode([], acc), do: acc

  defp do_encode([head | tail], acc) do
    do_encode(tail, <<acc::bitstring, encode_nucleotide(head)::size(4)>>)
  end

  @spec decode(bitstring) :: list(char)
  def decode(dna), do: do_decode(dna, [])

  @spec do_decode(bitstring, list(char)) :: list(char)
  defp do_decode(<<>>, acc), do: acc

  defp do_decode(<<head::size(4), tail::bitstring>>, acc) do
    do_decode(tail, acc ++ [decode_nucleotide(head)])
  end
end
