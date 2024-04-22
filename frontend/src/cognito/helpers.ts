import {
  AuthenticationDetails,
  ChallengeName,
  CognitoUser,
  CognitoUserAttribute,
  CognitoUserSession,
  ICognitoUserData,
} from "amazon-cognito-identity-js";
import UserPool from "./UserPool";

interface AuthenticateUserResp {
  type: string;
  cognitoUser: CognitoUser;

  session?: CognitoUserSession;
  userConfirmationNecessary?: boolean;
  accessToken?: string;
  refreshToken?: string;

  userAttributes?: CognitoUserAttribute[];
  requiredAttributes?: any;

  challengeName?: ChallengeName;
  challengeParameters?: any;
}

function getUser(email: string) {
  const userData: ICognitoUserData = {
    Username: email,
    Pool: UserPool,
  };

  return new CognitoUser(userData);
}

export async function AuthenticateUser(
  email: string,
  password: string
): Promise<AuthenticateUserResp> {
  return new Promise((resolve, reject) => {
    const cognitoUser = getUser(email);

    const authenticationData = {
      Username: email,
      Password: password,
    };
    const authenticationDetails = new AuthenticationDetails(authenticationData);

    cognitoUser.authenticateUser(authenticationDetails, {
      onSuccess: (session, userConfirmationNecessary) => {
        const accessToken = session.getAccessToken().getJwtToken();
        const refreshToken = session.getRefreshToken().getToken();
        resolve({
          type: "SUCCESS",
          session,
          userConfirmationNecessary,
          cognitoUser,
          accessToken,
          refreshToken,
        });
      },

      onFailure: (err) => reject(err),

      newPasswordRequired: (
        userAttributes: CognitoUserAttribute[],
        requiredAttributes
      ) => {
        resolve({
          type: "NEW_PASSWORD_REQUIRED",
          userAttributes,
          requiredAttributes,
          cognitoUser,
        });
      },

      totpRequired: (challengeName, challengeParameters) => {
        resolve({
          type: "TOTP_REQUIRED",
          challengeName,
          challengeParameters,
          cognitoUser,
        });
      },

      mfaSetup: (challengeName, challengeParameters) => {
        resolve({
          type: "MFA_SETUP",
          challengeName,
          challengeParameters,
          cognitoUser,
        });
      },
    });
  });
}

export async function confirmSignUp(code: string, email: string) {
  const cognitoUser = getUser(email);
  await new Promise((resolve, reject) => {
    cognitoUser.confirmRegistration(code, true, (err: Error, result) => {
      if (err) reject(err);
      if (result) resolve(cognitoUser);
    });
  });
}

export function resendCode(email: string) {
  const cognitoUser = getUser(email);
  cognitoUser.resendConfirmationCode((err, result) => {
    if (err) {
      // Some error message on screen or a toast
      return;
    }
    console.log(result);
    // Some toast or message displayed on screen of success
  });
}

export async function signUp(name: string, email: string, password: string) {
  const attributeList = [
    new CognitoUserAttribute({
      Name: "email",
      Value: email,
    }),
  ];

  await new Promise((resolve, reject) => {
    UserPool.signUp(name, password, attributeList, [], (error, result) => {
      if (error) reject(error);
      if (result) resolve(result);
    });
  });
}
