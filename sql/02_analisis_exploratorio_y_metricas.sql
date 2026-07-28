-- ============================================================================
-- PROYECTO: Análisis de Producción Petrolera
-- ARCHIVO: 02_analisis_exploratorio_y_metricas.sql
-- DESCRIPCIÓN: Consultas de agregación, métricas operativas (GOR), 
--              clasificaciones con CASE WHEN y subconsultas escalares.
-- ============================================================================

USE petroleos_db; -- Cambia al nombre de tu base de datos
GO

-- ----------------------------------------------------------------------------
-- 1. Producción Anual Agrupada por Activo
-- ----------------------------------------------------------------------------
SELECT
    activo,
    anio,
    SUM(produccion_crudo) AS volumen_total_crudo,
    SUM(produccion_gas) AS volumen_total_gas
FROM datos
GROUP BY activo, anio
ORDER BY activo ASC, anio ASC;


-- ----------------------------------------------------------------------------
-- 2. Meses con Producción de Crudo Superior a 50 Millones
-- ----------------------------------------------------------------------------
SELECT
    anio,
    mes,
    SUM(produccion_crudo) AS produccion_total_crudo
FROM datos
GROUP BY anio, mes
HAVING SUM(produccion_crudo) > 50000000;


-- ----------------------------------------------------------------------------
-- 3. Promedio de Gas y Máximo Crudo para el Año 2023
-- ----------------------------------------------------------------------------
SELECT
    activo,
    AVG(produccion_gas) AS promedio_gas,
    MAX(produccion_crudo) AS max_crudo
FROM datos
WHERE anio = 2023
GROUP BY activo
HAVING AVG(produccion_gas) > 1000000
ORDER BY promedio_gas DESC;


-- ----------------------------------------------------------------------------
-- 4. Cálculo del Ratio Gas-Petróleo (GOR) Estándar (SCF/BBL) y Categorización
-- Nota: La fuente reporta Gas en MPC y Crudo en BPPM. Se multiplica por 1,000 
-- para llevarlo a la unidad estándar SCF/BBL.
-- ----------------------------------------------------------------------------
WITH gor_calculado AS (
    SELECT
        activo,
        SUM(produccion_crudo) AS total_crudo,
        SUM(produccion_gas) AS total_gas,
        ROUND((SUM(produccion_gas) * 1000) / NULLIF(SUM(produccion_crudo), 0), 4) AS gor
    FROM datos
    WHERE anio = 2023
    GROUP BY activo
)
SELECT
    activo,
    ROUND(total_crudo, 4) AS total_crudo_bppm,
    ROUND(total_gas, 4) AS total_gas_mpc,
    gor AS gor_scf_bbl,
    CASE
        WHEN gor > 500 THEN 'Alto en gas'
        WHEN gor BETWEEN 200 AND 500 THEN 'Balanceado'
        ELSE 'Predominante Crudo'
    END AS categoria_gor
FROM gor_calculado
ORDER BY gor DESC;


-- ----------------------------------------------------------------------------
-- 5. Activos con Producción Superior al Promedio Nacional (2023)
-- ----------------------------------------------------------------------------
WITH total_activo_2023 AS (
    SELECT
        activo,
        SUM(produccion_crudo) AS suma_crudo
    FROM datos
    WHERE anio = 2023
    GROUP BY activo
)
SELECT
    activo,
    ROUND(suma_crudo, 2) AS suma_crudo
FROM total_activo_2023
WHERE suma_crudo > (SELECT AVG(suma_crudo) FROM total_activo_2023)
ORDER BY suma_crudo DESC;
