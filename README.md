# Scripts para IQ Option

## `scripts/usdcad_otc_senales.lua`

Indicador de señales CALL/PUT para **USD/CAD (OTC)**. Combina:

- **Cruce de EMAs** (9/21): marca el cambio de tendencia si el RSI no está en extremo.
- **Rebote en Bandas de Bollinger** (20, 2): el precio toca la banda, el RSI está en
  sobrecompra o sobreventa y la vela gira.

Todos los parámetros se pueden cambiar desde la configuración del indicador.

### Cómo importarlo

1. Abre IQ Option (web o escritorio) y selecciona el activo **USD/CAD (OTC)**.
2. Entra en **Indicadores → Scripts** y pulsa **Crear script** (o *Nuevo script*).
3. Borra el código de ejemplo y pega todo el contenido de `scripts/usdcad_otc_senales.lua`.
4. Guarda el script y aplícalo al gráfico.
5. Usa una vela de 1 a 5 minutos y prueba **primero en la cuenta de práctica**.

Si el editor muestra un error, copia el mensaje y la línea para corregirlo.

### Advertencias

- El script solo dibuja señales. **No abre operaciones automáticamente.**
- El mercado OTC usa precios que genera el propio bróker, no el mercado interbancario real.
  Los indicadores técnicos tienen ahí aún menos fiabilidad.
- Las opciones binarias son de muy alto riesgo. Ninguna señal garantiza ganancias.
