shader_type canvas_item;

uniform vec2 pixel_size = vec2(4.0, 4.0); // Tamaño del píxel en relación con la textura

void fragment() {
    // Escala las coordenadas de textura a la cuadrícula pixelada
    vec2 uv = FRAGCOORD.xy / SCREEN_PIXEL_SIZE;
    uv = floor(uv / pixel_size) * pixel_size;

    // Recupera el color original y lo asigna al píxel ajustado
    vec4 color = texture(TEXTURE, uv);
    
    // Asigna el color pixelado al fragmento
    COLOR = color;
}
