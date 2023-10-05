import { createContext, useContext } from "react";
import { useNavigate } from "react-router-dom";
import { Path } from "../../constant";
import { useChatStore } from "../../store";
import { Bot, useBotStore } from "../../store/bot";
import { useSidebarContext } from "../home";
import { Updater } from "@/app/typing";

const BotItemContext = createContext<{
  bot: Bot;
  isActive: boolean;
  isBuiltin: boolean;
  isShareble: boolean;
  ensureSession: () => void;
  cloneBot: () => void;
  deleteBot: () => void;
  updateBot: Updater<Bot>;
}>({} as any);

export const BotItemContextProvider = (props: {
  bot: Bot;
  children: JSX.Element;
}) => {
  const bot = props.bot;
  const chatStore = useChatStore();
  const botStore = useBotStore();
  const navigate = useNavigate();
  const { setShowSidebar } = useSidebarContext();

  const cloneBot = () => {
    const newBot = botStore.create(bot, {
      reset: true,
    });
    newBot.name = `My ${bot.name}`;
  };

  const isBuiltin = bot.builtin;
  const isShareble = !!bot.share;

  const ensureSession = () => {
    navigate(Path.Home);
    chatStore.ensureSession(bot);
    setShowSidebar(false);
  };

  const deleteBot = () => {
    botStore.delete(bot.id);
  };

  const updateBot: Updater<Bot> = (updater) => {
    botStore.update(bot.id, updater);
  };

  const isActive = chatStore.currentSession().bot.id === props.bot.id;

  return (
    <BotItemContext.Provider
      value={{
        bot,
        isActive,
        isBuiltin,
        isShareble,
        ensureSession,
        cloneBot,
        deleteBot,
        updateBot,
      }}
    >
      {props.children}
    </BotItemContext.Provider>
  );
};

export const useBot = () => useContext(BotItemContext);