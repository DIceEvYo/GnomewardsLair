shader_type canvas_item;


// How jagged each band of melting pixels are
// This is also the amplitude of the wave
instance uniform float meltness: hint_range(0.0, 3.0) = 2.0;

// If it should affect only lower parts of the shader, it also increases the meltness
instance uniform float how_deep: hint_range(0.0, 5.0) = 1.0;

// Speed
instance uniform float speed: hint_range(0.1, 10.0 ) = 3;

// How wavy.
instance uniform float wave_frequency: hint_range(0.0, 30.0) = 10.0;

float wave(float val) {
	return val - 2.5 + cos(2.0 * speed * TIME + wave_frequency * val);
}

void fragment() {
	vec2 uv = UV;
	vec2 orig_uv = UV;

	// Bottom
	uv.y -= pow(orig_uv.y, how_deep) * 0.02 * meltness * wave(orig_uv.x - mod(orig_uv.x, TEXTURE_PIXEL_SIZE.x));
	// Top
	uv.y += pow(1.0 - orig_uv.y, how_deep) * 0.02 * meltness * wave(orig_uv.x - mod(orig_uv.x, TEXTURE_PIXEL_SIZE.x));
	// Right
	uv.x -= pow(orig_uv.x, how_deep) * 0.02 * meltness * wave(orig_uv.y - mod(orig_uv.y, TEXTURE_PIXEL_SIZE.y));
	// Left
	uv.x += pow(1.0 - orig_uv.x, how_deep) * 0.02 * meltness * wave(orig_uv.y - mod(orig_uv.y, TEXTURE_PIXEL_SIZE.y));

	COLOR = texture(TEXTURE, uv);

	if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) {
		COLOR.a = 0.0;
	}
}
