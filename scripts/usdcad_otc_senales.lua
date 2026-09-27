-- USD/CAD (OTC) - Señales CALL/PUT
-- Indicador para el editor de scripts de IQ Option.
-- Combina tendencia (cruce de EMAs), RSI y Bandas de Bollinger.
-- Solo dibuja señales en el gráfico: NO abre operaciones.
-- Pensado para velas de 1 a 5 minutos.

instrument {
    name = "USD/CAD OTC Señales",
    short_name = "USDCAD_OTC",
    overlay = true,
    icon = "indicators:MA"
}

input_group {
    "Tendencia (EMA)",
    ema_rapida = input(9, "EMA rápida", input.integer, 1, 200),
    ema_lenta = input(21, "EMA lenta", input.integer, 1, 200),
}

input_group {
    "RSI",
    rsi_periodo = input(14, "Periodo", input.integer, 2, 100),
    rsi_sobrecompra = input(70, "Sobrecompra", input.integer, 50, 100),
    rsi_sobreventa = input(30, "Sobreventa", input.integer, 0, 50),
}

input_group {
    "Bollinger",
    bb_periodo = input(20, "Periodo", input.integer, 2, 100),
    bb_desv = input(2.0, "Desviaciones", input.double, 0.5, 5.0, 0.1),
}

input_group {
    "Colores",
    color_call = input { default = "#2CAC40", type = input.color },
    color_put = input { default = "#DB4931", type = input.color },
}

-- Cálculos
local rapida = ema(close, ema_rapida)
local lenta = ema(close, ema_lenta)
local r = rsi(close, rsi_periodo)

local base = sma(close, bb_periodo)
local desv = stdev(close, bb_periodo) * bb_desv
local banda_sup = base + desv
local banda_inf = base - desv

-- Líneas en el gráfico
plot(rapida, "EMA rápida", "#3FA9F5")
plot(lenta, "EMA lenta", "#F5A623")
plot(banda_sup, "BB superior", "#888888")
plot(banda_inf, "BB inferior", "#888888")

-- Señal 1: cruce de EMAs a favor de la tendencia, con RSI sin extremos
local cruce_alcista = rapida > lenta and rapida[1] <= lenta[1] and r < rsi_sobrecompra
local cruce_bajista = rapida < lenta and rapida[1] >= lenta[1] and r > rsi_sobreventa

-- Señal 2: rebote en banda de Bollinger con RSI en extremo y vela de giro
local rebote_alcista = low <= banda_inf and r < rsi_sobreventa and close > open
local rebote_bajista = high >= banda_sup and r > rsi_sobrecompra and close < open

plot_shape(cruce_alcista or rebote_alcista, "CALL",
    shape_style.arrowup, shape_size.huge, color_call,
    shape_location.belowbar, 0, "CALL", color_call)

plot_shape(cruce_bajista or rebote_bajista, "PUT",
    shape_style.arrowdown, shape_size.huge, color_put,
    shape_location.abovebar, 0, "PUT", color_put)
