import { Container, getContainer } from "@cloudflare/containers";
import OAuthProvider from "@cloudflare/workers-oauth-provider";
import { handleAccessRequest } from "./access-handler";

export class MyContainer extends Container<Env> {
	defaultPort = 8080;
	sleepAfter = "2m";
}

async function handleMcpRequest(req: Request, env: Env, ctx: ExecutionContext) {
	const container = getContainer(env.MY_CONTAINER);
	return await container.fetch(req);
}

export default new OAuthProvider({
	apiHandler: { fetch: handleMcpRequest as any },
	apiRoute: ["/*"],
	authorizeEndpoint: "/authorize",
	clientRegistrationEndpoint: "/register",
	defaultHandler: { fetch: handleAccessRequest as any },
	tokenEndpoint: "/token",
});
