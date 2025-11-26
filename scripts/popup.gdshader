shader_type canvas_item;
uniform vec4 overlay_color : source_color = vec4(0.0, 0.0, 0.0, 0.7); // A cor do overlay
uniform vec2 ellipse_center_uv = vec2(0.5, 0.5); // O centro do formato oval
uniform vec2 ellipse_radius_uv = vec2(0.1, 0.1); // Os raios do formato oval: vec2(raio_x, raio_y)

void fragment() 
{
    vec2 dist_vec = UV - ellipse_center_uv; // Calcula a distância do pixel atual até o centro
   
    // Calcula a distância da elipse: (x^2 / raio_x^2) + (y^2 / raio_y^2)
    float ellipse_dist = (dist_vec.x * dist_vec.x) / (ellipse_radius_uv.x * ellipse_radius_uv.x)
                       + (dist_vec.y * dist_vec.y) / (ellipse_radius_uv.y * ellipse_radius_uv.y);
    vec4 color = overlay_color; // Começa com a cor do overlay
    
    // Se a distância for < 1, o pixel está dentro do oval
    if (ellipse_dist < 1.0) 
    {
        color.a = 0.0; // Torna o pixel totalmente transparente
    }
    COLOR = color;
}