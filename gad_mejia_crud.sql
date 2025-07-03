SELECT * FROM gestion.ges_propietario
ORDER BY pro_id 

SELECT COUNT(*) AS total_propietarios
FROM gestion.ges_propietario;



SELECT 
  column_name, 
  data_type, 
  character_maximum_length
FROM information_schema.columns
WHERE table_schema = 'gestion' 
  AND table_name = 'ges_propietario';



SELECT 
  column_name, 
  data_type, 
  character_maximum_length
FROM information_schema.columns
WHERE table_schema = 'gestion' 
  AND table_name = 'ges_catalogo';


SELECT * FROM gestion.ges_catalogo
ORDER BY cat_id 

SELECT pro_id, pro_fecha_nacimiento FROM gestion.ges_propietario WHERE pro_fecha_nacimiento > '9999-12-31';


UPDATE gestion.ges_propietario
SET pro_fecha_nacimiento = '1999-11-21'
WHERE pro_fecha_nacimiento = '19991-11-21';


SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_name = 'propietario_20200410';




SELECT 
  column_name, 
  data_type, 
  character_maximum_length
FROM information_schema.columns
WHERE table_schema = 'gestion' 
  AND table_name = 'ges_propietario_test';

ALTER USER postgres SET search_path = gestion;


SELECT COUNT(*) AS total_propietarios FROM gestion.ges_propietario;


-- Porcentaje de propietarios con correo
SELECT ROUND(100.0 * COUNT() / (SELECT COUNT() FROM gestion.ges_propietario), 2) AS porcentaje_con_correo
FROM gestion.ges_propietario WHERE pro_correo_electronico IS NOT NULL;

--Número de propietarios por ciudad

SELECT pro_direccion_ciudad, COUNT(*) AS total
FROM gestion.ges_propietario
WHERE pro_direccion_ciudad IS NOT NULL
  AND TRIM(pro_direccion_ciudad) <> ''
GROUP BY pro_direccion_ciudad
ORDER BY total DESC
LIMIT 10;

-- Edad promedio de propietario
SELECT ROUND(AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, pro_fecha_nacimiento)))) AS edad_promedio
FROM gestion.ges_propietario WHERE pro_fecha_nacimiento IS NOT NULL;


-- 13. Número de propietarios por tipo de persona (1: Natural, 0: Jurídica)

SELECT 
  CASE 
    WHEN pro_tipo_persona = 1 THEN 'Natural'
    WHEN pro_tipo_persona = 0 THEN 'Jurídica'
    ELSE 'Desconocido'
  END AS tipo_persona,
  COUNT(*) AS total
FROM gestion.ges_propietario
GROUP BY pro_tipo_persona;

--  Número de propietarios por sexo (1: Hombre, 0: Mujer)
SELECT pro_sexo, COUNT(*) FROM gestion.ges_propietario GROUP BY pro_sexo;
-- Número de propietarios por sexo 
SELECT 
  CASE 
    WHEN pro_sexo = 1 THEN 'Hombre'
    WHEN pro_sexo = 0 THEN 'Mujer'
    ELSE 'Sin definir'
  END AS sexo,
  COUNT(*) AS total
FROM gestion.ges_propietario
GROUP BY pro_sexo;


--  Top 5 tags más frecuentes
SELECT cat_tag, COUNT() FROM gestion.ges_catalogo GROUP BY cat_tag ORDER BY COUNT() DESC LIMIT 5;

-- Tipos de identificación más utilizados
SELECT c.cat_nombre AS tipo_identificacion, COUNT(*) AS total
FROM gestion.ges_propietario p
JOIN gestion.ges_catalogo c ON p.opc_tipoidentificacion = c.cat_id
GROUP BY c.cat_nombre
ORDER BY total DESC;



--  Nombres de estado civil por cantidad de propietarios

SELECT c.cat_nombre AS estado_civil, COUNT(*) AS total_personas
FROM gestion.ges_propietario p
JOIN gestion.ges_catalogo c ON p.opc_estado_civil = c.cat_id
GROUP BY c.cat_nombre
ORDER BY total_personas DESC


-- Categorías más reutilizadas como padre
SELECT 
  padre.cat_nombre AS nombre_padre,
  hijo.cat_id_padre,
  COUNT(*) AS total
FROM gestion.ges_catalogo hijo
JOIN gestion.ges_catalogo padre
  ON hijo.cat_id_padre = padre.cat_id
WHERE hijo.cat_id_padre IS NOT NULL
GROUP BY hijo.cat_id_padre, padre.cat_nombre
ORDER BY total DESC
LIMIT 5;
-- FECHA PROPIETARIOS POR MES
SELECT 
    DATE_TRUNC('month', pro_fecha_nacimiento) AS mes,
    COUNT(*) AS total_propietarios
FROM gestion.ges_propietario
WHERE pro_fecha_nacimiento IS NOT NULL
GROUP BY mes
ORDER BY mes DESC
LIMIT 15;



SELECT DISTINCT cat_tag FROM gestion.ges_catalogo;





SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_name = 'cat_predio';


SELECT COUNT(*) FROM catastro.cat_predio;


SELECT 
  column_name, 
  data_type, 
  character_maximum_length
FROM information_schema.columns
WHERE table_schema = 'catastro' 
  AND table_name = 'cat_predio';




SELECT * FROM catastro.cat_predio
ORDER BY pre_id ASC LIMIT 100


-- insertar predio
CREATE OR REPLACE PROCEDURE catastro.sp_insertar_cat_predio(
    p_pre_codigo_catastral VARCHAR,
    p_pre_fecha_ingreso TIMESTAMP,
    p_pre_codigo_anterior VARCHAR,
    p_pre_numero VARCHAR,
    p_pre_nombre_predio VARCHAR,
    p_pre_area_total_ter NUMERIC,
    p_pre_area_total_const NUMERIC,
    p_pre_fondo_relativo NUMERIC,
    p_pre_frente_fondo NUMERIC,
    p_pre_observaciones VARCHAR,
    p_pre_dim_tomado_planos VARCHAR,
    p_pre_otra_fuente_info VARCHAR,
    p_pre_num_nuevo_bloque VARCHAR,
    p_pre_num_ampli_bloque SMALLINT,
    p_pre_tipo SMALLINT,
    p_pre_propiedad_horizontal VARCHAR,
    p_pre_estado SMALLINT,
    p_pre_dominio INTEGER,
    p_pre_num_habitantes INTEGER,
    p_pre_propietario_anterior VARCHAR,
    p_pre_carta_topografica VARCHAR,
    p_pre_foto_aerea VARCHAR,
    p_man_id SMALLINT,
    p_pre_num_familias SMALLINT,
    p_pre_porcentaje_dominio NUMERIC,
    p_pre_detalle_dominio VARCHAR,
    p_pre_tipo_mixto SMALLINT,
    p_pre_valor_tipo_mixto NUMERIC,
    p_pre_linderos_definidos SMALLINT,
    p_pre_area_total_terreno_anterior NUMERIC,
    p_pre_localizacion_otros VARCHAR,
    p_pre_bien_mostrenco SMALLINT,
    p_pre_en_conflicto SMALLINT,
    p_pre_area_total_ter_grafico NUMERIC,
    p_pre_propietario_desconocido SMALLINT,
    p_pre_area_total_ter_alfanumerico NUMERIC,
    p_pre_dominio_detalle SMALLINT,
    p_pre_direccion_principal VARCHAR,
    p_pre_area_total_const_alfanumerico NUMERIC,
    p_pre_tipo_vivienda VARCHAR,
    p_opc_clasificacion_vivienda INTEGER,
    p_pre_fecha_modificacion TIMESTAMP,
    p_pre_num_celulares SMALLINT,
    p_pre_modalidad_propiedad_horizontal SMALLINT,
    p_pre_alicuota_total_declaratoria NUMERIC,
    p_pre_tipo_propiedad_horizontal SMALLINT,
    p_pre_observacion_ph VARCHAR,
    p_pre_hipoteca_gad SMALLINT,
    p_pre_regimen_propiedad_horizontal SMALLINT,
    p_pre_prorrateo_titulo SMALLINT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO catastro.cat_predio (
        pre_codigo_catastral,
        pre_fecha_ingreso,
        pre_codigo_anterior,
        pre_numero,
        pre_nombre_predio,
        pre_area_total_ter,
        pre_area_total_const,
        pre_fondo_relativo,
        pre_frente_fondo,
        pre_observaciones,
        pre_dim_tomado_planos,
        pre_otra_fuente_info,
        pre_num_nuevo_bloque,
        pre_num_ampli_bloque,
        pre_tipo,
        pre_propiedad_horizontal,
        pre_estado,
        pre_dominio,
        pre_num_habitantes,
        pre_propietario_anterior,
        pre_carta_topografica,
        pre_foto_aerea,
        man_id,
        pre_num_familias,
        pre_porcentaje_dominio,
        pre_detalle_dominio,
        pre_tipo_mixto,
        pre_valor_tipo_mixto,
        pre_linderos_definidos,
        pre_area_total_terreno_anterior,
        pre_localizacion_otros,
        pre_bien_mostrenco,
        pre_en_conflicto,
        pre_area_total_ter_grafico,
        pre_propietario_desconocido,
        pre_area_total_ter_alfanumerico,
        pre_dominio_detalle,
        pre_direccion_principal,
        pre_area_total_const_alfanumerico,
        pre_tipo_vivienda,
        opc_clasificacion_vivienda,
        pre_fecha_modificacion,
        pre_num_celulares,
        pre_modalidad_propiedad_horizontal,
        pre_alicuota_total_declaratoria,
        pre_tipo_propiedad_horizontal,
        pre_observacion_ph,
        pre_hipoteca_gad,
        pre_regimen_propiedad_horizontal,
        pre_prorrateo_titulo
    ) VALUES (
        p_pre_codigo_catastral,
        p_pre_fecha_ingreso,
        p_pre_codigo_anterior,
        p_pre_numero,
        p_pre_nombre_predio,
        p_pre_area_total_ter,
        p_pre_area_total_const,
        p_pre_fondo_relativo,
        p_pre_frente_fondo,
        p_pre_observaciones,
        p_pre_dim_tomado_planos,
        p_pre_otra_fuente_info,
        p_pre_num_nuevo_bloque,
        p_pre_num_ampli_bloque,
        p_pre_tipo,
        p_pre_propiedad_horizontal,
        p_pre_estado,
        p_pre_dominio,
        p_pre_num_habitantes,
        p_pre_propietario_anterior,
        p_pre_carta_topografica,
        p_pre_foto_aerea,
        p_man_id,
        p_pre_num_familias,
        p_pre_porcentaje_dominio,
        p_pre_detalle_dominio,
        p_pre_tipo_mixto,
        p_pre_valor_tipo_mixto,
        p_pre_linderos_definidos,
        p_pre_area_total_terreno_anterior,
        p_pre_localizacion_otros,
        p_pre_bien_mostrenco,
        p_pre_en_conflicto,
        p_pre_area_total_ter_grafico,
        p_pre_propietario_desconocido,
        p_pre_area_total_ter_alfanumerico,
        p_pre_dominio_detalle,
        p_pre_direccion_principal,
        p_pre_area_total_const_alfanumerico,
        p_pre_tipo_vivienda,
        p_opc_clasificacion_vivienda,
        p_pre_fecha_modificacion,
        p_pre_num_celulares,
        p_pre_modalidad_propiedad_horizontal,
        p_pre_alicuota_total_declaratoria,
        p_pre_tipo_propiedad_horizontal,
        p_pre_observacion_ph,
        p_pre_hipoteca_gad,
        p_pre_regimen_propiedad_horizontal,
        p_pre_prorrateo_titulo
    );
END;
$$;

-- actualizar


CREATE OR REPLACE PROCEDURE catastro.sp_actualizar_cat_predio(
    p_pre_id BIGINT,
    p_pre_codigo_catastral VARCHAR,
    p_pre_fecha_ingreso TIMESTAMP,
    p_pre_codigo_anterior VARCHAR,
    p_pre_numero VARCHAR,
    p_pre_nombre_predio VARCHAR,
    p_pre_area_total_ter NUMERIC,
    p_pre_area_total_const NUMERIC,
    p_pre_fondo_relativo NUMERIC,
    p_pre_frente_fondo NUMERIC,
    p_pre_observaciones VARCHAR,
    p_pre_dim_tomado_planos VARCHAR,
    p_pre_otra_fuente_info VARCHAR,
    p_pre_num_nuevo_bloque VARCHAR,
    p_pre_num_ampli_bloque SMALLINT,
    p_pre_tipo SMALLINT,
    p_pre_propiedad_horizontal VARCHAR,
    p_pre_estado SMALLINT,
    p_pre_dominio INTEGER,
    p_pre_num_habitantes INTEGER,
    p_pre_propietario_anterior VARCHAR,
    p_pre_carta_topografica VARCHAR,
    p_pre_foto_aerea VARCHAR,
    p_man_id SMALLINT,
    p_pre_num_familias SMALLINT,
    p_pre_porcentaje_dominio NUMERIC,
    p_pre_detalle_dominio VARCHAR,
    p_pre_tipo_mixto SMALLINT,
    p_pre_valor_tipo_mixto NUMERIC,
    p_pre_linderos_definidos SMALLINT,
    p_pre_area_total_terreno_anterior NUMERIC,
    p_pre_localizacion_otros VARCHAR,
    p_pre_bien_mostrenco SMALLINT,
    p_pre_en_conflicto SMALLINT,
    p_pre_area_total_ter_grafico NUMERIC,
    p_pre_propietario_desconocido SMALLINT,
    p_pre_area_total_ter_alfanumerico NUMERIC,
    p_pre_dominio_detalle SMALLINT,
    p_pre_direccion_principal VARCHAR,
    p_pre_area_total_const_alfanumerico NUMERIC,
    p_pre_tipo_vivienda VARCHAR,
    p_opc_clasificacion_vivienda INTEGER,
    p_pre_fecha_modificacion TIMESTAMP,
    p_pre_num_celulares SMALLINT,
    p_pre_modalidad_propiedad_horizontal SMALLINT,
    p_pre_alicuota_total_declaratoria NUMERIC,
    p_pre_tipo_propiedad_horizontal SMALLINT,
    p_pre_observacion_ph VARCHAR,
    p_pre_hipoteca_gad SMALLINT,
    p_pre_regimen_propiedad_horizontal SMALLINT,
    p_pre_prorrateo_titulo SMALLINT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE catastro.cat_predio SET
        pre_codigo_catastral = p_pre_codigo_catastral,
        pre_fecha_ingreso = p_pre_fecha_ingreso,
        pre_codigo_anterior = p_pre_codigo_anterior,
        pre_numero = p_pre_numero,
        pre_nombre_predio = p_pre_nombre_predio,
        pre_area_total_ter = p_pre_area_total_ter,
        pre_area_total_const = p_pre_area_total_const,
        pre_fondo_relativo = p_pre_fondo_relativo,
        pre_frente_fondo = p_pre_frente_fondo,
        pre_observaciones = p_pre_observaciones,
        pre_dim_tomado_planos = p_pre_dim_tomado_planos,
        pre_otra_fuente_info = p_pre_otra_fuente_info,
        pre_num_nuevo_bloque = p_pre_num_nuevo_bloque,
        pre_num_ampli_bloque = p_pre_num_ampli_bloque,
        pre_tipo = p_pre_tipo,
        pre_propiedad_horizontal = p_pre_propiedad_horizontal,
        pre_estado = p_pre_estado,
        pre_dominio = p_pre_dominio,
        pre_num_habitantes = p_pre_num_habitantes,
        pre_propietario_anterior = p_pre_propietario_anterior,
        pre_carta_topografica = p_pre_carta_topografica,
        pre_foto_aerea = p_pre_foto_aerea,
        man_id = p_man_id,
        pre_num_familias = p_pre_num_familias,
        pre_porcentaje_dominio = p_pre_porcentaje_dominio,
        pre_detalle_dominio = p_pre_detalle_dominio,
        pre_tipo_mixto = p_pre_tipo_mixto,
        pre_valor_tipo_mixto = p_pre_valor_tipo_mixto,
        pre_linderos_definidos = p_pre_linderos_definidos,
        pre_area_total_terreno_anterior = p_pre_area_total_terreno_anterior,
        pre_localizacion_otros = p_pre_localizacion_otros,
        pre_bien_mostrenco = p_pre_bien_mostrenco,
        pre_en_conflicto = p_pre_en_conflicto,
        pre_area_total_ter_grafico = p_pre_area_total_ter_grafico,
        pre_propietario_desconocido = p_pre_propietario_desconocido,
        pre_area_total_ter_alfanumerico = p_pre_area_total_ter_alfanumerico,
        pre_dominio_detalle = p_pre_dominio_detalle,
        pre_direccion_principal = p_pre_direccion_principal,
        pre_area_total_const_alfanumerico = p_pre_area_total_const_alfanumerico,
        pre_tipo_vivienda = p_pre_tipo_vivienda,
        opc_clasificacion_vivienda = p_opc_clasificacion_vivienda,
        pre_fecha_modificacion = p_pre_fecha_modificacion,
        pre_num_celulares = p_pre_num_celulares,
        pre_modalidad_propiedad_horizontal = p_pre_modalidad_propiedad_horizontal,
        pre_alicuota_total_declaratoria = p_pre_alicuota_total_declaratoria,
        pre_tipo_propiedad_horizontal = p_pre_tipo_propiedad_horizontal,
        pre_observacion_ph = p_pre_observacion_ph,
        pre_hipoteca_gad = p_pre_hipoteca_gad,
        pre_regimen_propiedad_horizontal = p_pre_regimen_propiedad_horizontal,
        pre_prorrateo_titulo = p_pre_prorrateo_titulo
    WHERE pre_id = p_pre_id;
END;
$$;

-- eliminar predio
CREATE OR REPLACE PROCEDURE catastro.sp_eliminar_cat_predio(
    p_pre_id BIGINT
)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM catastro.cat_predio WHERE pre_id = p_pre_id;
END;
$$;
DROP FUNCTION IF EXISTS catastro.fn_consultar_cat_predios();

-- consultar predio
CREATE OR REPLACE FUNCTION catastro.fn_consultar_cat_predios()
RETURNS TABLE (
    pre_id BIGINT,
    pre_codigo_catastral VARCHAR,
    pre_fecha_ingreso TIMESTAMPTZ,
    pre_codigo_anterior VARCHAR,
    pre_numero VARCHAR,
    pre_nombre_predio VARCHAR,
    pre_area_total_ter NUMERIC,
    pre_area_total_const NUMERIC,
    pre_fondo_relativo NUMERIC,
    pre_frente_fondo NUMERIC,
    pre_observaciones VARCHAR,
    pre_dim_tomado_planos VARCHAR,
    pre_otra_fuente_info VARCHAR,
    pre_num_nuevo_bloque VARCHAR,
    pre_num_ampli_bloque SMALLINT,
    pre_tipo SMALLINT,
    pre_propiedad_horizontal VARCHAR,
    pre_estado SMALLINT,
    pre_dominio INTEGER,
    pre_num_habitantes INTEGER,
    pre_propietario_anterior VARCHAR,
    pre_carta_topografica VARCHAR,
    pre_foto_aerea VARCHAR,
    man_id SMALLINT,
    pre_num_familias SMALLINT,
    pre_porcentaje_dominio NUMERIC,
    pre_detalle_dominio VARCHAR,
    pre_tipo_mixto SMALLINT,
    pre_valor_tipo_mixto NUMERIC,
    pre_linderos_definidos SMALLINT,
    pre_area_total_terreno_anterior NUMERIC,
    pre_localizacion_otros VARCHAR,
    pre_bien_mostrenco SMALLINT,
    pre_en_conflicto SMALLINT,
    pre_area_total_ter_grafico NUMERIC,
    pre_propietario_desconocido SMALLINT,
    pre_area_total_ter_alfanumerico NUMERIC,
    pre_dominio_detalle SMALLINT,
    pre_direccion_principal VARCHAR,
    pre_area_total_const_alfanumerico NUMERIC,
    pre_tipo_vivienda VARCHAR,
    opc_clasificacion_vivienda INTEGER,
    pre_fecha_modificacion TIMESTAMP,
    pre_num_celulares SMALLINT,
    pre_modalidad_propiedad_horizontal SMALLINT,
    pre_alicuota_total_declaratoria NUMERIC,
    pre_tipo_propiedad_horizontal SMALLINT,
    pre_observacion_ph VARCHAR,
    pre_hipoteca_gad SMALLINT,
    pre_regimen_propiedad_horizontal SMALLINT,
    pre_prorrateo_titulo SMALLINT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        pre_id,
        pre_codigo_catastral,
        pre_fecha_ingreso,
        pre_codigo_anterior,
        pre_numero,
        pre_nombre_predio,
        pre_area_total_ter,
        pre_area_total_const,
        pre_fondo_relativo,
        pre_frente_fondo,
        pre_observaciones,
        pre_dim_tomado_planos,
        pre_otra_fuente_info,
        pre_num_nuevo_bloque,
        pre_num_ampli_bloque,
        pre_tipo,
        pre_propiedad_horizontal,
        pre_estado,
        pre_dominio,
        pre_num_habitantes,
        pre_propietario_anterior,
        pre_carta_topografica,
        pre_foto_aerea,
        man_id,
        pre_num_familias,
        pre_porcentaje_dominio,
        pre_detalle_dominio,
        pre_tipo_mixto,
        pre_valor_tipo_mixto,
        pre_linderos_definidos,
        pre_area_total_terreno_anterior,
        pre_localizacion_otros,
        pre_bien_mostrenco,
        pre_en_conflicto,
        pre_area_total_ter_grafico,
        pre_propietario_desconocido,
        pre_area_total_ter_alfanumerico,
        pre_dominio_detalle,
        pre_direccion_principal,
        pre_area_total_const_alfanumerico,
        pre_tipo_vivienda,
        opc_clasificacion_vivienda,
        pre_fecha_modificacion,
        pre_num_celulares,
        pre_modalidad_propiedad_horizontal,
        pre_alicuota_total_declaratoria,
        pre_tipo_propiedad_horizontal,
        pre_observacion_ph,
        pre_hipoteca_gad,
        pre_regimen_propiedad_horizontal,
        pre_prorrateo_titulo
    FROM catastro.cat_predio;
END;
$$;


-- Verificar si la función existe con otro nombre
SELECT proname FROM pg_proc WHERE proname LIKE '%consultar_cat_predios%';


SELECT proname FROM pg_proc WHERE pronamespace = 'catastro'::regnamespace;

SELECT * FROM gestion.ges_propietario
ORDER BY pro_id 

SELECT * FROM catastro.cat_predio
ORDER BY pre_id


SELECT 
  column_name, 
  data_type, 
  character_maximum_length
FROM information_schema.columns
WHERE table_schema = 'gestion' 
  AND table_name = 'ges_propietario';


SELECT 
  column_name, 
  data_type, 
  character_maximum_length
FROM information_schema.columns
WHERE table_schema = 'catastro' 
  AND table_name = 'cat_predio';


 SELECT 
  column_name, 
  data_type, 
  character_maximum_length
FROM information_schema.columns
WHERE table_schema = 'catastro' 
  AND table_name = 'cat_parroquias';
-- top 5  propietarios con mayor numero de predios


-- total de predios por parroquia




gestion.ges_propietario
"pro_id"	"integer"
"opc_tipoidentificacion"	"integer"
"pro_num_identificacion"	"character varying"
"pro_nombre"	"character varying"
"pro_apellido"	"character varying"
"pro_direccion_ciudad"	"character varying"
"pro_direccion_domicilio"	"character varying"
"pro_direccion_referencia"	"character varying"
"pro_fecha_nacimiento"	"date"
"opc_estado_civil"	"integer"
"pro_sexo"	"smallint"
"pro_correo_electronico"	"character varying"
"pro_telefono1"	"character varying"
"pro_telefono2"	"character varying"
"pro_codigo_postal"	"character varying"
"pro_nro_conadis"	"character varying"
"pro_porcentaje_conadis"	"numeric"
"opc_tipo_conadis"	"integer"
"pro_validado"	"date"
"opc_tipo_entidad"	"integer"
"pro_tipo_persona"	"smallint"
"pro_numero_registro"	"character varying"
"pro_genero"	"character varying"
"pro_inscrito_en"	"character varying"
"pro_lugar_inscripcion"	"character varying"
"pro_id_cliente"	"bigint"
"pro_tiene_ruc"	"smallint"
"pro_ruc"	"character varying"
"pro_razon_social_pn"	"character varying"
"pro_fecha_fallecido"	"date"







catastro.cat_predio
"pre_id"	"bigint"
"pre_codigo_catastral"	"character varying"
"pre_fecha_ingreso"	"timestamp with time zone"
"pre_codigo_anterior"	"character varying"
"pre_numero"	"character varying"
"pre_nombre_predio"	"character varying"
"pre_area_total_ter"	"numeric"
"pre_area_total_const"	"numeric"
"pre_fondo_relativo"	"numeric"
"pre_frente_fondo"	"numeric"
"pre_observaciones"	"character varying"
"pre_dim_tomado_planos"	"character varying"
"pre_otra_fuente_info"	"character varying"
"pre_num_nuevo_bloque"	"character varying"
"pre_num_ampli_bloque"	"smallint"
"pre_tipo"	"smallint"
"pre_propiedad_horizontal"	"character varying"
"pre_estado"	"smallint"
"pre_dominio"	"integer"
"geometria"	"USER-DEFINED"
"opc_condicion_ocupacion"	"integer"
"pre_num_habitantes"	"integer"
"pre_propietario_anterior"	"character varying"
"pre_carta_topografica"	"character varying"
"pre_foto_aerea"	"character varying"
"man_id"	"smallint"
"pre_num_familias"	"smallint"
"pre_porcentaje_dominio"	"numeric"
"pre_detalle_dominio"	"character varying"
"pre_tipo_mixto"	"smallint"
"pre_valor_tipo_mixto"	"numeric"
"pre_linderos_definidos"	"smallint"
"pre_area_total_terreno_anterior"	"numeric"
"pre_localizacion_otros"	"character varying"
"pre_bien_mostrenco"	"smallint"
"pre_en_conflicto"	"smallint"
"pre_area_total_ter_grafico"	"numeric"
"pre_propietario_desconocido"	"smallint"
"pre_area_total_ter_alfanumerico"	"numeric"
"pre_dominio_detalle"	"smallint"
"pre_direccion_principal"	"character varying"
"pre_area_total_const_alfanumerico"	"numeric"
"pre_tipo_vivienda"	"character varying"
"opc_clasificacion_vivienda"	"integer"
"pre_fecha_modificacion"	"timestamp without time zone"
"pre_num_celulares"	"smallint"
"pre_modalidad_propiedad_horizontal"	"smallint"
"pre_alicuota_total_declaratoria"	"numeric"
"pre_tipo_propiedad_horizontal"	"smallint"
"pre_observacion_ph"	"character varying"
"pre_hipoteca_gad"	"smallint"
"pre_regimen_propiedad_horizontal"	"smallint"
"pre_prorrateo_titulo"	"smallint"



catastro.cat_parroquias
"par_id"	"integer"
"can_id"	"integer"
"par_nombre"	"character varying"
"par_codigo"	"character varying"
"par_tipo"	"smallint"
"geometria"	"USER-DEFINED"


SELECT 
    man_id,
    COUNT(*) AS total_predios
FROM 
    catastro.cat_predio
GROUP BY 
    man_id
ORDER BY 
    total_predios DESC;