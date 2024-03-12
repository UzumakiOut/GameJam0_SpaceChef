extends MeshInstance3D


var arrowColor = Color(1,1,1);


func _ready():
	get_surface_override_material(0).albedo_color = arrowColor;
	get_surface_override_material(0).emission = arrowColor;


func _process(_delta):
	get_surface_override_material(0).albedo_color = arrowColor;
	get_surface_override_material(0).emission = arrowColor;
