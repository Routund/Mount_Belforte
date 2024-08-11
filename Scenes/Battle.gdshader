shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR.g=1.0-COLOR.g;
	COLOR.r=1.0-COLOR.r;
	COLOR.b=1.0-COLOR.b;
	// Called for every pixel the material is visible on.
}

void light() {
	// Called for every pixel for every light affecting the CanvasItem.
}
