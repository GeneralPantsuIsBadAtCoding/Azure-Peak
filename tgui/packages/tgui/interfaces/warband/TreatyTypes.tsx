export type TerritoryType = {
  name: string;
  desc: string;
  type: string;
}

export type UserType = {
  name: string;
  desc: string;
  type: string;
}

export type FactionType = {
  name: string;
  desc: string;
  type: string;
}


export type Data = {
  user_role?: string;
  finalized_status?: boolean;
  factions?: FactionType[];
  people?: UserType[];
};
