# Cursada · Ingeniería Industrial (versión propia)

Tu sitio de la facu, hospedado gratis en **GitHub Pages**, con los datos y archivos en tu **Supabase**. No depende de Claude.

| Archivo | Para qué es |
|---|---|
| `index.html` | La página completa |
| `config.js` | Tus dos datos de Supabase (los completás vos) |
| `supabase.sql` | Crea la tabla y el depósito de archivos, con permisos para que solo vos veas lo tuyo |
| `manifest.webmanifest`, `icon.svg` | Para instalarla en el celu como app |

Tus datos actuales **no** están en esta carpeta: están en `UTN 2026/cursada-migracion` y no se suben a GitHub.

---

## Paso 1 · Supabase (base de datos y archivos), ~7 minutos

1. Entrá a <https://supabase.com>, creá una cuenta y tocá **New project**.
   - Nombre: `cursada`. Región: **South America (São Paulo)**. Plan: **Free**.
   - Elegí una contraseña de base de datos y guardala (no la vas a necesitar para la página).
2. Cuando termine de crearse, andá a **SQL Editor → New query**, pegá todo el contenido de `supabase.sql` y tocá **Run**. Tiene que decir *Success*.
3. Andá a **Project Settings → API** y copiá:
   - **Project URL**
   - la clave **anon public**
   Pegalas en `config.js`, entre las comillas. **No uses la clave `service_role`.**

## Paso 2 · GitHub Pages (hospedaje), ~5 minutos

1. Entrá a <https://github.com>, creá una cuenta y un repositorio nuevo, por ejemplo `cursada`. Tiene que ser **Public** (GitHub Pages gratis lo pide; tus datos no van ahí, solo el código).
2. En el repositorio: **Add file → Upload files** y arrastrá los 5 archivos de esta carpeta (`index.html`, `config.js`, `manifest.webmanifest`, `icon.svg`, `LEEME.md`). `supabase.sql` es opcional. **Commit changes.**
3. **Settings → Pages → Branch: `main` / `(root)` → Save.** En un minuto te da la dirección, del estilo `https://tuusuario.github.io/cursada/`.

## Paso 3 · Conectar el login, ~1 minuto

En Supabase: **Authentication → URL Configuration**
- **Site URL**: tu dirección de GitHub Pages (`https://tuusuario.github.io/cursada/`)
- **Redirect URLs**: agregá la misma dirección.

Esto hace que el link que te llega por mail te lleve a tu página.

## Paso 4 · Entrar y mudar tus datos

1. Abrí tu dirección, poné tu mail y tocá **Mandame el link**. Abrí el mail **en el mismo dispositivo** y tocá el link.
2. En la página: **Ajustes → Restaurar una copia** → elegí `cursada-migracion/copia-cursada-AAAA-MM-DD.json`.
3. Volvé a **Ajustes → Restaurar una copia** y, en **archivos de la copia**, seleccioná todos los archivos de `cursada-migracion/archivos` (los 9 modelos de termo). Se suben solos.
4. Listo. En el celu: abrí la dirección, entrá con el mismo mail y usá **Agregar a pantalla de inicio**.
5. **Cerrá los registros:** en Supabase → **Authentication → Sign In / Providers** (o *Settings*), desactivá **Allow new users to sign up**. Vos seguís entrando; nadie más puede crearse una cuenta en tu proyecto.

## Seguridad

- **Tus datos:** cada fila y cada archivo están atados a tu usuario por reglas de la base (RLS). La clave pública de `config.js` sola no deja leer nada.
- **Registros cerrados** (paso 5): nadie más puede usar tu proyecto ni tu espacio gratis.
- **Librerías externas verificadas:** Supabase y el visor de PDF se cargan con huella (SRI); si alguien los altera en la CDN, el navegador no los ejecuta.
- **Datos saneados:** todo lo que se carga o se restaura se limpia (fechas, horas, números, links solo `http(s)`).
- **Lo que depende de vos:** tu mail es la llave. Activá la verificación en dos pasos en tu mail, en GitHub y en Supabase. Nunca pegues la clave `service_role` en ningún lado. Solo restaurá copias tuyas.

---

## Bueno saber

- **Gratis:** Supabase Free alcanza de sobra (500 MB de datos, 1 GB de archivos). Si en **7 días nadie entra**, Supabase pausa el proyecto: no se pierde nada y se reactiva desde su panel con **Restore project**.
- **Mails de login:** el plan gratis manda pocos mails por hora. Como la sesión queda abierta, casi nunca vas a necesitar uno nuevo.
- **Copia de seguridad:** igual que antes, en **Ajustes → Descargar copia**. Hacela una vez por mes.
- **Actualizar la página:** si hay una versión nueva de `index.html`, la subís al repositorio reemplazando la anterior. Tus datos no se tocan.
