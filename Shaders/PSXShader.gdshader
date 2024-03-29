shader_type spatial;
render_mode vertex_lighting, skip_vertex_transform, 
			specular_toon, diffuse_lambert_wrap, cull_disabled;

uniform sampler2D albedo: source_color, filter_nearest_mipmap;
uniform sampler2D specular: hint_default_black;

uniform float jitter: hint_range(0.0, 1.0) = 0.5;
uniform bool jitter_z_coordinate = true;
uniform bool jitter_depth_independent = true;
uniform bool affine_texture_mapping = true;
uniform float alpha_scissor: hint_range(0.0, 1.0) = 1.0;
uniform bool triplanar = false;
//emission
uniform float emissiveBoost = 0;
//texture panning
uniform vec2 Direction = vec2(0.0,0.0);
uniform float Speed = 0.0;
uniform vec2 UVScale = vec2(1.0,1.0);

void vertex() {
	VERTEX = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
	
	float z_orig = VERTEX.z;
	float i = (1.0 - jitter) * min(VIEWPORT_SIZE.x, VIEWPORT_SIZE.y) / 2.0;
	
	if (jitter_depth_independent) {
		float w = (PROJECTION_MATRIX * vec4(VERTEX, 1.0)).w;
		VERTEX = round(VERTEX / w * i) / i * w;
	} else {
		VERTEX = round(VERTEX * i) / i;
	}
	
	if (!jitter_z_coordinate) {
		VERTEX.z = z_orig;
	}

	if (affine_texture_mapping) {
		UV *= VERTEX.z;
	}
}

void fragment() {
	vec2 uv = UV * UVScale;
	
	if (affine_texture_mapping) {
		uv /= VERTEX.z;
	}
	
	
	
	ALBEDO = texture(albedo, uv + Direction * TIME * Speed).rgb; //Find a way to make this update a lower frame rate for aesthetic reasons
	ALPHA = texture(albedo, uv).a;
	ALPHA_SCISSOR_THRESHOLD = alpha_scissor;
	EMISSION = texture(albedo, uv + Direction * TIME * Speed).rgb * emissiveBoost;
	SPECULAR = texture(specular, uv).r;
}