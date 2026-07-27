-- ============================================================
-- Proyecto: Análisis de Producción Petrolera
-- Script: 02_consultas_avanzadas.sql
-- Objetivo: Consultas analíticas (MoM, Running Total, Ranking)
-- ============================================================

-- 1. Comparativa de Producción Mensual (MoM) con LAG()
SELECT
    anio,
    mes,
    activo,
    produccion_crudo,
    LAG(produccion_crudo, 1) OVER(
        PARTITION BY activo 
        ORDER BY anio ASC, mes ASC
    ) AS produccion_mes_anterior,
    produccion_crudo - LAG(produccion_crudo, 1) OVER(
        PARTITION BY activo 
        ORDER BY anio ASC, mes ASC
    ) AS diferencia_mom
FROM datos;


-- 2. Producción Acumulada Anual (Running Total / YTD)
SELECT
    anio,
    mes,
    activo,
    produccion_crudo,
    SUM(produccion_crudo) OVER(
        PARTITION BY activo, anio 
        ORDER BY mes ASC
    ) AS crudo_acumulado_anio
FROM datos;


-- 3. Ranking Top 3 de Activos por Año con DENSE_RANK()
WITH suma_anual AS (
    SELECT
        anio,
        activo,
        SUM(produccion_crudo) AS total_crudo_anio
    FROM datos
    GROUP BY anio, activo
),
ranking_activos AS (
    SELECT
        anio,
        activo,
        total_crudo_anio,
        DENSE_RANK() OVER(
            PARTITION BY anio 
            ORDER BY total_crudo_anio DESC
        ) AS posicion_ranking
    FROM suma_anual
)
SELECT 
    anio,
    posicion_ranking,
    activo,
    total_crudo_anio
FROM ranking_activos
WHERE posicion_ranking <= 3
ORDER BY anio ASC, posicion_ranking ASC;
