shader_type canvas_item;

// A COR DO OVERLAY (preto semi-transparente)
uniform vec4 overlay_color : source_color = vec4(0.0, 0.0, 0.0, 0.7);

// O CENTRO DO OVAL (em coordenadas UV 0-1)
uniform vec2 ellipse_center_uv = vec2(0.5, 0.5);

// OS RAIOS DO OVAL (em coordenadas UV 0-1)
// vec2(raio_x, raio_y)
uniform vec2 ellipse_radius_uv = vec2(0.1, 0.1);

void fragment() {
    // Calcula a distância do pixel atual até o centro
    vec2 dist_vec = UV - ellipse_center_uv;
    
    // Calcula a "distância da elipse". Esta é a matemática mágica.
    // (x^2 / raio_x^2) + (y^2 / raio_y^2)
    float ellipse_dist = (dist_vec.x * dist_vec.x) / (ellipse_radius_uv.x * ellipse_radius_uv.x)
                       + (dist_vec.y * dist_vec.y) / (ellipse_radius_uv.y * ellipse_radius_uv.y);

    // Começa com a cor do overlay
    vec4 color = overlay_color;
    
    // Se a distância for < 1, o pixel está DENTRO do oval
    if (ellipse_dist < 1.0) {
        // Torna o pixel totalmente transparente
        color.a = 0.0;
    }

    COLOR = color;
}