shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR.g = COLOR.g*2.0;
	COLOR.r = COLOR.r*2.0;
	COLOR.b = COLOR.b/2.0;
	// Called for every pixel the material is visible on.
}

void light() {
	// Called for every pixel for every light affecting the material.
}
