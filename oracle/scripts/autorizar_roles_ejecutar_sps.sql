-- Script para permitir que los roles ejecuten SPs.
-- ROL CLIENTE
grant execute on system.sp_ver_items_de_usuario to cliente;
grant execute on system.sp_get_nombres_categorias to cliente;
grant execute on system.sp_get_nombres_subcategorias to cliente;
grant execute on system.sp_get_subastas_cat_subcat to cliente;
grant execute on system.sp_ver_pujas_de_subasta to cliente;