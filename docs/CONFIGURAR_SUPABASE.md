# Preparar el backend de OLI con Supabase

Esta guía crea la base segura para guardar proyectos en la nube. La aplicación publicada en GitHub Pages sigue siendo una página estática; Supabase aporta la base de datos y la autenticación.

## Qué permite esta primera etapa

- Cada proyecto pertenece a una cuenta autenticada.
- Las reglas de seguridad de la base de datos impiden que una cuenta lea o cambie los proyectos de otra.
- El contenido de los archivos se guarda como JSON, con un límite inicial de 512 KB por proyecto.
- Este paso prepara la base de datos, pero **todavía no conecta la interfaz ni importa proyectos de Replit**.

## Pasos desde el navegador del teléfono

1. Abre [supabase.com](https://supabase.com/) e inicia sesión o crea una cuenta.
2. Crea un proyecto nuevo para OLI. Guarda la contraseña de la base de datos en un lugar privado; no la compartas en chats ni la pongas en GitHub.
3. Espera a que Supabase termine de preparar el proyecto.
4. En el panel del proyecto, abre **SQL Editor** y crea una consulta nueva.
5. En este repositorio, abre [`supabase/schema.sql`](../supabase/schema.sql), copia todo el contenido y pégalo en el editor SQL de Supabase.
6. Pulsa **Run**. Si Supabase muestra que la consulta terminó correctamente, la tabla ya está preparada.

## Seguridad: qué claves sí y no

- **Nunca** pongas la contraseña de la base de datos, una `service_role` key ni un secreto en `index.html`, el chat, una captura o el repositorio.
- La clave pública `publishable` (o la antigua `anon`) está diseñada para usarse en el navegador, pero solo después de comprobar que las políticas RLS están activas. No es una contraseña; las reglas de la base de datos son las que protegen los datos.
- No desactives Row Level Security (RLS) ni ejecutes consultas que permitan acceso anónimo a todos los proyectos.
- En caso de duda, no compartas valores: indica solo el mensaje de error y oculta cualquier clave, contraseña, correo o identificador privado.

## Lo que sigue

Después de crear la tabla, el siguiente paso será añadir el inicio de sesión y conectar el guardado de OLI usando únicamente la configuración pública de Supabase. No publiques todavía datos importantes ni uses esta versión para información sensible; primero probaremos el aislamiento entre cuentas.
