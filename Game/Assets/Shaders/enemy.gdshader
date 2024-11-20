shader_type canvas_item;

void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);
	if (tex_color.a < 0.1) {
		discard; // Transparente Pixel ignorieren
	}

	// Wende die Texturfarbe an und erhöhe die Helligkeit für den Glow-Effekt
	COLOR = tex_color;
	COLOR.rgb += vec3(1.0, 0.0, 0.0) * 0.8; // Rot leuchtend mit 80% Stärke
	COLOR.a = tex_color.a * 1.5; // Alpha auf 50% reduzieren
}
