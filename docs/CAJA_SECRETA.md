# Caja secreta — diseño seguro para APEX IA NODES

> **Este archivo es documentación, no un almacén de credenciales.** No pegues aquí claves, contraseñas, tokens, datos de jugadores ni registros privados. El repositorio y GitHub Pages son públicos; cualquier secreto guardado en un archivo del sitio sería visible para todos.

## Objetivo

Preparar la plataforma para crecer de pruebas a producción en vivo sin límites artificiales de arquitectura, manteniendo controles de seguridad, cumplimiento y operación. La capacidad se escala según la infraestructura contratada; no se relajan controles de acceso para conseguir escalabilidad.

## Dónde guardar secretos

- **Desarrollo local:** archivo `.env.local` solo en el equipo, excluido del control de versiones mediante `.gitignore`. Usar valores ficticios en ejemplos.
- **CI/CD:** secretos de GitHub Actions únicamente para tareas de compilación y despliegue que realmente los necesiten. No imprimirlos en logs.
- **Backend en producción:** gestor de secretos del proveedor de nube (por ejemplo, AWS Secrets Manager, Google Secret Manager, Azure Key Vault o equivalente). El backend obtiene secretos mediante identidad de servicio; el navegador nunca los recibe.
- **No usar:** `index.html`, JavaScript del navegador, GitHub Pages, commits, issues, chats, capturas de pantalla, `localStorage` ni logs como almacén de secretos.

## Separación de entornos

Mantener proyectos, bases de datos, cuentas de proveedores y credenciales diferentes para `development`, `staging` y `production`. Una clave de pruebas no debe funcionar en producción ni una clave de producción en pruebas. La promoción a producción debe ser explícita, auditable y reversible.

## Controles mínimos para cada secreto

1. Acceso de mínimo privilegio por servicio y entorno; no compartir una clave maestra entre agentes o componentes.
2. Identidad de servicio y credenciales de corta duración cuando el proveedor lo admita.
3. Cifrado en tránsito y en reposo, rotación documentada y revocación inmediata ante exposición.
4. No incluir secretos ni datos personales en logs, errores, analítica, prompts de agentes o respuestas al navegador. Enmascarar valores sensibles antes de registrar.
5. Registrar auditoría de quién/qué servicio accedió, cuándo y con qué propósito, sin registrar el valor del secreto.
6. Alertar por accesos anómalos y fallos repetidos; limitar solicitudes para proteger disponibilidad y costes.
7. Copias de seguridad y recuperación probadas sin exportar secretos a repositorios.

## Agentes de IA y herramientas

- Los agentes de desarrollo trabajan con datos sintéticos y credenciales de sandbox por defecto.
- No entregar a un agente acceso directo a credenciales de producción, pagos, retiros, cuentas de jugadores o cambios irreversibles.
- Las herramientas se habilitan por tarea con permisos acotados, lista permitida de acciones y registro de auditoría.
- Revisar y probar cambios antes de desplegarlos. Para acciones financieras o cambios de producción, exigir autorización humana y controles del backend.
- Ejecutar código de usuario o integraciones no confiables en aislamiento desechable, sin acceso a secretos, red privada ni datos productivos.

## Logs y datos operativos

Los logs deben excluir contraseñas, tokens, claves, datos completos de pago y datos personales innecesarios. Aplicar minimización, control de acceso, retención definida, protección contra alteración y auditoría. En paneles y alertas usar datos agregados o identificadores seudónimos cuando sea posible.

## Lista de comprobación antes de live

- [ ] Backend y API desplegados aparte del sitio estático.
- [ ] Secret manager configurado para producción; ningún secreto en Git.
- [ ] Pruebas automatizadas, revisión de seguridad y recuperación verificadas.
- [ ] Autenticación fuerte, roles, aislamiento por organización y auditoría.
- [ ] Integraciones de proveedores aprobadas y probadas en sandbox.
- [ ] Límites operativos contra abuso, fallos y costes; alertas y respuesta a incidentes disponibles.
- [ ] Requisitos legales, licencias, edad, ubicación, privacidad, pagos y juego responsable revisados para cada jurisdicción.
- [ ] Despliegue gradual con monitoreo y procedimiento de reversión.

## Si una clave se expone

Revocarla/rotarla inmediatamente en el proveedor, revisar auditoría y actividad, reemplazarla en el gestor de secretos, eliminarla del código y del historial cuando corresponda, y comprobar que los logs no la hayan copiado. Borrar un archivo del último commit por sí solo no invalida una clave expuesta.

## Estado

Este documento no configura un gestor de secretos ni crea un backend. La aplicación publicada en GitHub Pages es solo frontend estático y no puede proteger claves privadas. Antes de conectar proveedores o datos reales hay que elegir un backend y un proveedor de infraestructura, e implementar autenticación, permisos y almacenamiento seguro allí.

**Nunca envíes claves reales en este chat.** Si ya compartiste alguna, considérala expuesta y rótala con el proveedor.
