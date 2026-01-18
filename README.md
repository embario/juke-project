# Juke Platform

Backend services for the Juke Music Service now ship with a React-based analyst console located at `web/` and the SwiftUI mobile client now lives alongside it under `mobile/`.

## Running the stack

1. Duplicate `template.env` into `.env` and populate the secrets as needed, including `BACKEND_URL` (defaults to `http://localhost:8000` for the browser-facing frontend).
2. Start the local services, including the new frontend container:

	 ```bash
	 docker-compose up --build
	 ```

	 The Django API stays on `http://localhost:8000` and the web console lives on `http://localhost:5173`.

## Frontend development

- The React application resides in `web/` with Vite + TypeScript.
- To run the app outside of Docker:

	```bash
	cd web
	npm install
	npm run dev
	```

	You can override the backend target via `VITE_API_BASE_URL`.

## Mobile app

- The native SwiftUI client from the former iOS repository has been moved into `mobile/`.
- Open the project with Xcode via `xed mobile/juke-iOS.xcodeproj`.
- Use the existing `juke-iOS` scheme for running on simulators or devices; it continues to build against the same bundle identifiers.

## Tests

- Backend: `docker-compose exec web python manage.py test`
- Frontend: `cd web && npm test`

GitHub Actions (see `.github/workflows/ci.yml`) runs linting plus both suites on every push and pull request targeting `main`.
