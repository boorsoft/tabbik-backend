import { relations } from "drizzle-orm";
import {
  boolean,
  index,
  integer,
  pgEnum,
  pgTable,
  serial,
  text,
  timestamp,
  varchar,
} from "drizzle-orm/pg-core";

export const tournamentRoomPosition = pgEnum("tournamentRoomPosition", [
  "OPENING_GOVERNMENT",
  "CLOSING_GOVERNMENT",
  "OPENING_OPPOSITION",
  "CLOSING_OPPOSITION",
]);

export const tournament = pgTable(
  "tournament",
  {
    id: serial("id").primaryKey(),
    title: varchar("title", { length: 256 }).unique().notNull(),
    description: text("description").notNull(),
    icon: varchar("icon", { length: 256 }),
    location: varchar("location", { length: 256 }).notNull(),
    ownerId: varchar("ownerId", { length: 256 }).notNull(),
    maxTeams: integer("maxTeams").notNull(),
    registrationFee: integer("registrationFee").notNull(),
    isActive: boolean("isActive").default(false),
    startDate: timestamp("startDate").defaultNow(),
    endDate: timestamp("endDate").notNull(),
    createdAt: timestamp("createdAt").defaultNow(),
    updatedAT: timestamp("updatedAt").defaultNow(),
  },
  (table) => ({
    titleIdx: index("titleIdx").on(table.title),
  })
);

export const tournamentJoinRequest = pgTable(
  "tournament_join_request",
  {
    id: serial("id").primaryKey(),
    firstSpeakerId: varchar("firstSpeakerId", { length: 256 }).notNull(),
    secondSpeakerId: varchar("secondSpeakerId", { length: 256 }).notNull(),
    teamTitle: varchar("teamTitle", { length: 120 }).unique(),
    isApproved: boolean("isApproved").default(false),
    tournamentId: integer("tournamentId")
      .references(() => tournament.id, { onDelete: "cascade" })
      .notNull(),
    createdAt: timestamp("createdAt").defaultNow(),
    updatedAT: timestamp("updatedAt").defaultNow(),
  },
  (table) => ({ teamTitleIdx: index("teamTitleIdx").on(table.teamTitle) })
);

export const tournamentTeam = pgTable(
  "tournament_team",
  {
    id: serial("id").primaryKey(),
    title: varchar("title", { length: 160 }),
    firstSpeakerId: varchar("firstSpeakerId").notNull(),
    secondSpeakerId: varchar("secondSpeakerId").notNull(),
    tournamentId: integer("tournamentId")
      .references(() => tournament.id, { onDelete: "cascade" })
      .notNull(),
    createdAt: timestamp("createdAt").defaultNow(),
    updatedAT: timestamp("updatedAt").defaultNow(),
  },
  (table) => ({ titleIdx: index("titleIdx").on(table.title) })
);

export const tournamentJudge = pgTable("tournament_judge", {
  id: serial("id").primaryKey(),
  judgeId: varchar("judgeId", { length: 256 }).notNull(),
  tournamentId: integer("tournamentId")
    .references(() => tournament.id, {
      onDelete: "cascade",
    })
    .notNull(),
  createdAt: timestamp("createdAt").defaultNow(),
  updatedAT: timestamp("updatedAt").defaultNow(),
});

export const tournamentUserSpeakerPoint = pgTable(
  "tournament_user_speaker_point",
  {
    id: serial("id").primaryKey(),
    userId: varchar("userId", { length: 256 }).notNull(),
    tournamentId: integer("tournamentId")
      .references(() => tournament.id, {
        onDelete: "cascade",
      })
      .notNull(),
    speakerPoints: integer("speakerPoints").notNull(),
    createdAt: timestamp("createdAt").defaultNow(),
    updatedAT: timestamp("updatedAt").defaultNow(),
  }
);

export const tournamentJudgePoint = pgTable("tournament_judge_point", {
  id: serial("id").primaryKey(),
  judgeId: varchar("judgeId", { length: 256 }).notNull(),
  tournamentId: integer("tournamentId")
    .references(() => tournament.id, {
      onDelete: "cascade",
    })
    .notNull(),
  points: integer("points").notNull(),
  createdAt: timestamp("createdAt").defaultNow(),
  updatedAT: timestamp("updatedAt").defaultNow(),
});

export const tournamentRound = pgTable(
  "tournament_round",
  {
    id: serial("id").primaryKey(),
    round: integer("round").notNull(),
    resolution: text("resolution").notNull(),
    isClosed: boolean("isClosed").default(false),
    tournamentId: integer("tournamentId")
      .references(() => tournament.id, {
        onDelete: "cascade",
      })
      .notNull(),
    createdAt: timestamp("createdAt").defaultNow(),
    updatedAT: timestamp("updatedAt").defaultNow(),
  },
  (table) => ({ resolutionIdx: index("resolutionIdx").on(table.resolution) })
);

export const tournamentRoundPoint = pgTable("tournament_round_point", {
  id: serial("id").primaryKey(),
  roundId: integer("roundId")
    .references(() => tournamentRound.id, {
      onDelete: "cascade",
    })
    .notNull(),
  points: integer("points").notNull(),
  createdAt: timestamp("createdAt").defaultNow(),
  updatedAT: timestamp("updatedAt").defaultNow(),
});

export const tournamentRoom = pgTable("tournament_room", {
  id: serial("id").primaryKey(),
  tournamentId: integer("tournamentId")
    .references(() => tournament.id, {
      onDelete: "cascade",
    })
    .notNull(),
  judgeId: varchar("judgeId", { length: 256 }).notNull(),
  room: integer("room"),
  createdAt: timestamp("createdAt").defaultNow(),
  updatedAT: timestamp("updatedAt").defaultNow(),
});

export const tournamentRoomTeam = pgTable("tournament_room_team", {
  id: serial("id").primaryKey(),
  teamId: integer("teamId")
    .references(() => tournamentTeam.id, {
      onDelete: "cascade",
    })
    .notNull(),
  roomId: integer("roomId")
    .references(() => tournamentRoom.id, { onDelete: "cascade" })
    .notNull(),
  position: tournamentRoomPosition("tournamentRoomPosition"),
  createdAt: timestamp("createdAt").defaultNow(),
  updatedAT: timestamp("updatedAt").defaultNow(),
});

export const userTournamentTeamInvitation = pgTable(
  "user_tournament_team_invitation",
  {
    id: serial("id").primaryKey(),
    inviterId: varchar("inviterId", { length: 256 }).notNull(),
    receiverId: varchar("receiverId", { length: 256 }).notNull(),
    isAccepted: boolean("isAccepted").default(false),
    createdAt: timestamp("createdAt").defaultNow(),
    updatedAT: timestamp("updatedAt").defaultNow(),
  }
);

// Relations

export const tournamentRelations = relations(tournament, ({ many }) => ({
  joinRequests: many(tournamentJoinRequest),
  teams: many(tournamentTeam),
  judges: many(tournamentJudge),
  userSpeakerPoints: many(tournamentUserSpeakerPoint),
  judegPoints: many(tournamentJudgePoint),
  rounds: many(tournamentRound),
  rooms: many(tournamentRoom),
}));

export const tournamentJoinRequestRelations = relations(
  tournamentJoinRequest,
  ({ one }) => ({
    tournament: one(tournament, {
      fields: [tournamentJoinRequest.tournamentId],
      references: [tournament.id],
    }),
  })
);

export const tournamentTeamRelations = relations(tournamentTeam, ({ one }) => ({
  tournament: one(tournament, {
    fields: [tournamentTeam.tournamentId],
    references: [tournament.id],
  }),
}));

export const tournamentJudgeRelations = relations(
  tournamentJudge,
  ({ one }) => ({
    tournament: one(tournament, {
      fields: [tournamentJudge.tournamentId],
      references: [tournament.id],
    }),
  })
);

export const tournamentUserSpeakerPointRelations = relations(
  tournamentUserSpeakerPoint,
  ({ one }) => ({
    tournament: one(tournament, {
      fields: [tournamentUserSpeakerPoint.tournamentId],
      references: [tournament.id],
    }),
  })
);

export const tournamentJudgePointRelations = relations(
  tournamentJudgePoint,
  ({ one }) => ({
    tournament: one(tournament, {
      fields: [tournamentJudgePoint.tournamentId],
      references: [tournament.id],
    }),
  })
);

export const tournamentRoundRelations = relations(
  tournamentRound,
  ({ one, many }) => ({
    tournament: one(tournament, {
      fields: [tournamentRound.tournamentId],
      references: [tournament.id],
    }),
    roundPoints: many(tournamentRoundPoint),
  })
);

export const tournamentRoundPointRelations = relations(
  tournamentRoundPoint,
  ({ one }) => ({
    round: one(tournamentRound, {
      fields: [tournamentRoundPoint.roundId],
      references: [tournamentRound.id],
    }),
  })
);

export const tournamentRoomRelations = relations(
  tournamentRoom,
  ({ one, many }) => ({
    tournament: one(tournament, {
      fields: [tournamentRoom.tournamentId],
      references: [tournament.id],
    }),
    roomTeams: many(tournamentRoomTeam),
  })
);

export const tournamentRoomTeamRelations = relations(
  tournamentRoomTeam,
  ({ one }) => ({
    team: one(tournamentTeam, {
      fields: [tournamentRoomTeam.teamId],
      references: [tournamentTeam.id],
    }),
    room: one(tournamentRoom, {
      fields: [tournamentRoomTeam.roomId],
      references: [tournamentRoom.id],
    }),
  })
);
