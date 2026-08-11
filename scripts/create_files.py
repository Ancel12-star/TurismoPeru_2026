from pathlib import Path

# Ruta Carpetas
carpetas= ["database","models","controllers","templates", "static","procedures"]

for carpeta in carpetas:
    ruta= Path.cwd() / f"./{carpeta}" #indicando la ruta para las carpetas
    ruta.mkdir(parents=True, exist_ok=True)
    print (f'{carpeta } lista en {ruta}')