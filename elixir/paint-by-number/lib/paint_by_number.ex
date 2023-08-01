defmodule PaintByNumber do
  @type color_count :: integer()
  @type memo :: integer()
  @type count :: integer()

  @doc """
  Takes in a count of colors in an image palette and returns how many bits are
  necessary to represent that many colors as binary numbers.
  """
  @spec palette_bit_size(color_count(), memo(), count()) :: integer()
  def palette_bit_size(color_count), do: palette_bit_size(color_count, 2, 1)

  defp palette_bit_size(color_count, memo, count) when color_count > memo do
    palette_bit_size(color_count, memo * 2, count + 1)
  end

  defp palette_bit_size(_color_count, _memo, count), do: count

  # Returns an empty picture.
  @spec empty_picture() :: binary
  def empty_picture(), do: <<>>

  # Returns a test picture.
  @spec test_picture() :: binary
  def test_picture(), do: <<0::2, 1::2, 2::2, 3::2>>

  # Prepends a pixel to a picture.
  @spec prepend_pixel(binary(), color_count(), integer()) :: binary()
  def prepend_pixel(picture, color_count, pixel_color_index) do
    <<pixel_color_index::size(palette_bit_size(color_count)), picture::bitstring>>
  end

  # Get the first pixel of a picture, returns nil if the picture is empty.
  @spec get_first_pixel(binary(), color_count()) :: integer() | nil
  def get_first_pixel(<<>>, _color_count), do: nil

  def get_first_pixel(picture, color_count) do
    pixel_size = palette_bit_size(color_count)
    <<pixel::size(pixel_size), _rest::bitstring>> = picture
    pixel
  end

  # Drops the first pixel of a picture or returns nil if picture is empty.
  @spec drop_first_pixel(binary(), color_count()) :: binary()
  def drop_first_pixel(<<>>, _color_count), do: <<>>

  def drop_first_pixel(picture, color_count) do
    pixel_size = palette_bit_size(color_count)
    <<_pixel::size(pixel_size), rest::bitstring>> = picture
    rest
  end

  # Concatenates two pictures.
  @spec concat_pictures(binary(), binary()) :: binary()
  def concat_pictures(picture1, picture2), do: <<picture1::bitstring, picture2::bitstring>>
end
