##📖 Guía de instalación y configuración en Windows

**1. 🖥️ Entorno base

****1.1 Instalar Git Bash
- Descarga desde: git-scm.com  
- Durante la instalación:
  - Selecciona "Use Git from Git Bash only".
  - Configura "Use Windows default console" para compatibilidad.
  - Activa "Enable symbolic links" si lo permite.

****1.2 Instalar VS Code
- Descarga desde: code.visualstudio.com  
- Extensiones recomendadas (se instalan luego con Ctrl+Shift+X):
  - ESLint, Prettier, Tailwind CSS IntelliSense, GitLens, MongoDB for VS Code, Svelte.

****1.3 Instalar FNM (Node.js version manager)
En Git Bash:
`bash
curl -fsSL https://fnm.vercel.app/install | bash
`
Agrega a tu ~/.bashrc:
`bash
eval "$(fnm env --use-on-cd)"
`
Reinicia Git Bash y prueba:
`bash
fnm install --lts
fnm use --lts
`

****1.4 Instalar pnpm
`bash
npm install -g pnpm
`

****1.5 Variables de entorno
Instala dependencias globales:
`bash
pnpm add -g cross-env dotenv
`

---

**2. 🧱 Backend con MongoDB

****2.1 Instalar MongoDB
- Descarga MongoDB Community Server: mongodb.com/try/download/community  
- Instala también MongoDB Compass (GUI opcional).  
- Agrega C:\Program Files\MongoDB\Server\<version>\bin al PATH.

****2.2 Inicializar proyecto backend
`bash
mkdir backend && cd backend
pnpm init
pnpm add express mongoose cors helmet dotenv
pnpm add -D nodemon
`

****2.3 Script básico server.js
`js
import express from "express";
import mongoose from "mongoose";
import cors from "cors";
import helmet from "helmet";
import dotenv from "dotenv";

dotenv.config();
const app = express();

app.use(cors());
app.use(helmet());
app.use(express.json());

mongoose.connect(process.env.MONGO_URI)
  .then(() => console.log("MongoDB conectado"))
  .catch(err => console.error(err));

app.get("/", (req, res) => res.send("API funcionando 🚀"));

app.listen(4000, () => console.log("Servidor en http://localhost:4000"));
`

En package.json:
`json
"scripts": {
  "dev": "nodemon server.js"
}
`

---

**3. 🎨 Frontend moderno

****3.1 Crear proyecto con Vite + Svelte
`bash
pnpm create vite frontend --template svelte
cd frontend
pnpm install
pnpm add -D tailwindcss postcss autoprefixer
npx tailwindcss init -p
`

**3.2 Configuración de Tailwind
En tailwind.config.cjs:
`js
content: ["./index.html", "./src//*.{svelte,js,ts}"],
theme: { extend: {} },
plugins: [],
`

En src/app.css:
`css
@tailwind base;
@tailwind components;
@tailwind utilities;
`

---

**4. 🧪 Testing y calidad

****4.1 Instalar herramientas
`bash
pnpm add -D vitest supertest eslint prettier husky lint-staged
`

****4.2 Configuración rápida
En package.json:
`json
"scripts": {
  "test": "vitest",
  "lint": "eslint . --ext .js,.svelte",
  "format": "prettier --write ."
},
"lint-staged": {
  "*.{js,ts,svelte,css,md}": ["eslint --fix", "prettier --write"]
}
`

Inicializa husky:
`bash
npx husky install
`

---

**5. 🔌 CLI y automatización

Instala utilidades:
`bash
pnpm add -D zx chalk inquirer commander
`

Ejemplo de script scripts/setup.mjs:
`js

!/usr/bin/env zx
import { $, question } from "zx";

const name = await question("Nombre del proyecto?");
await $mkdir ${name};
console.log(🚀 Proyecto ${name} creado);
`

---

**6. 🧭 Productividad y visualidad

- Obsidian: obsidian.md  
- Everything: voidtools.com  
- ShareX: getsharex.com  
- Twinkle Tray: github.com/xanderfrangos/twinkle-tray  

---

**7. ⚙️ Alias y scripts en Git Bash

En ~/.bashrc:
`bash
alias dev="pnpm run dev"
alias mongo="mongosh"
alias push="git add . && git commit -m 'update' && git push"

init_fullstack() {
  mkdir $1 && cd $1
  pnpm init -y
  pnpm add express mongoose cors helmet dotenv
  pnpm create vite frontend --template svelte
}
`
