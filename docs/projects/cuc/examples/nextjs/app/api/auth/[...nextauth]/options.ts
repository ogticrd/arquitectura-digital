import type { AuthOptions } from "next-auth";

export const options: AuthOptions = {
  providers: [
    {
      clientId: process.env.ORY_CLIENT_ID,
      clientSecret: process.env.ORY_CLIENT_SECRET,
      id: "ory",
      name: "Ory",
      type: "oauth",
      version: "2.0",
      wellKnown: `${process.env.ORY_URL}/.well-known/openid-configuration`,
      authorization: {
        params: {
          scope: "profile email openid",
          state: "dfsfeisroiewurouwreaisdfdkfjhdsfksfhksdfs",
        },
      },
      idToken: true,
      checks: ["pkce", "state"],
      profile: (profile) => ({
        id: profile.sub,
        name: profile.given_name,
        email: profile.email,
      }),
    },
  ],
  pages: {
    signIn: "/sign-out",
    signOut: "/sign-out",
  },
  secret: process.env.NEXTAUTH_SECRET,
};
