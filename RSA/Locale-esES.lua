local L = LibStub("AceLocale-3.0"):NewLocale("RSA", "esES")
if not L then return end

------------------------------------------------------------------------------
--- IN THE PROCESS OF REDOING THIS TO MAKE IT CLEARER TO READ AND UPDATE. ----
------------------------------------------------------------------------------
-- PRIMARY LOCALISATIONS
L["Tol Barad"] = "Tol Barad" -- a = select(32,GetMapZones(2)) Will this always return Tol Barad? It seems GetMapZones is alphabetised, maybe not the same order in other localisations?
L["Corpse of "] = "Cuerpo de " -- Tooltip mouseover of a released corpse.


-- PRIMARY LOCALISATIONS-->>BUFF REMINDER MODULE
L[" is Missing!"] = " falta!"
L[" Refreshed!"] = " renovado!"


-- PRIMARY LOCALISATIONS-->>SPELL ANNOUNCEMENTS
L["You"] = true
L["missed"] = true
L["was resisted by"] = true
L["Immune"] = true
L["Unknown"] = true


-- MAIN OPTIONS PANEL-->>GLOBAL OPTIONS & THEIR DESCRIPTIONS
L["Global Options"] = "Opciones globales"
L.Global_Options_Desc = "Aqui puedes configurar algunos aspectos generales qpara RSA que afectaran a todos tus anuncios."

L["About"] = "Acerca de"
L.About_Desc = "Bienvenido a RSA! Si estas atascado, ve a la pestaña de ayuda a la izquierda. Si aun no estas seguro, deja un comentario en Curse en: |cff33ff99http://wow.curse.com/downloads/wow-addons/details/rsa.aspx|r. Si encuentras un bug o tienes una futura peticion, pon un ticket en Curse en: |cff33ff99http://wow.curseforge.com/addons/rsa/tickets/|r."

L["Module Settings"] = "Opciones del modulo"
L.Module_Settings_Desc = "" -- None for now.

L["Enable Buff Reminder Module"] = "Activar modulo de Recordatorio de Beneficios"
L.Buff_Reminders_Desc = "Este modulo te permite ser avisado cuando te falte algun beneficio."

L["Announcement Options"] = "Opciones de anuncios"
L.Announcement_Options_Desc = "Estas opciones afectan a todos tus hechizos, pasa el raton sobre cada una para ver una descripcion completa de lo que hace."

L["Smart Say"] = "Decir Inteligente"
L.Smart_Say_Desc = "Activar esta opcion causara que anuncies los hechizos seleccionados en Decir |cffFF0000solo|r mientras estes en grupo."

L["Smart Custom Channel"] = "Canal personalizado Inteligente"
L.Smart_Custom_Channel_Desc = "Activar esta opcion causara que anuncies ciertos hechizos en tu canal personalizado |cffFF0000solo|r mientras estes en grupo."

L["Enable Only In Combat"] = "Activar solo en combate"
L.Enable_Only_In_Combat_Desc = "Activar esta opcion causara que solo envies anuncios miestras estes en combate."

L["Enable in Arenas"] = "Activar en arenas"
L.Enable_In_Arenas_Desc = "Activar esta opcion te permitira enviar anuncions miestras estas en Arenas."

L["Enable in Battlegrounds"] = "Activar en Campos de Batalla"
L.Enable_In_Battlegrounds_Desc = "Activar esta opcion te permitira enviar anuncios mientras estas es Campos de Batalla."

L["Enable in Dungeons"] = "Activar en Mazmorras"
L.Enable_In_Dungeons_Desc = "Activar esta opcion te permitira enviar anuncios minetras estas en Mazmorras y Heroicas de 5 personas."

L["Enable in Raid Instances"] = "Activar en instancias de Banda"
L.Enable_In_Raid_Instances_Desc = "Activar esta opcion te permitira enviar anuncios mientras estas en instancias de Banda."

L["Enable in Tol Barad"] = "Activar en Tol Barad"
L.Enable_In_Tol_Barad_Desc = "Activar esta opcion te permitira enviar anuncios en Tol Barad."

L["Enable in the World"] = "Activar en el mundo"
L.Enable_In_The_World_Desc = "Activar esta opcion te permitira enviar anuncios mientras estas en el mundo normal. En otras palabras, en cualquier situacion que no aparezca en cualquiera de las otras opciones."

L["Enable in PvP"] = "Activar en JcJ"
L.Enable_In_PvP_Desc = "Activar esta opcion te permitira enviar anuncios mientras tienes el JcJ activado, sin importar la ubicacion. Activar esto ocultara las opciones de lugares especificos pra las zonas JcJ."

L["Enable in Scenarios"] = "Activar en Escenarios"
L.Enable_In_Scenarios_Desc = "Activar esta opción te permitira enviar anuncios mientras estes en escenarios."

L["Enable in LFG"] = "Activar en buscador de grupo"
L.Enable_In_LFG_Desc = "Activar esta opcion te permitira enviar anuncios mientras estes en una mazmorra o banda de buscador."

-- MAIN OPTIONS PANEL-->>LIB SINK OUTPUT
L["Local Message Output Area"] = "Area de salida de mensaje Local"
L.Local_Message_Output_Area_Desc = "Hechizos que tienen activado \"local\" en sus opciones seran enviados a uno de los siguientes sitios, aqui puedes seleccionar cual."


-- MAIN OPTIONS PANEL-->>GENERAL ANNOUNCEMENTS
L["General Announcements"] = "Anuncios Generales"
L.General_Announcements_Desc = "Aqui puedes configurar anuncios que no son especificos de clase. Cosas como habilidaddes raciales, ventajas de hermandad, u otras cosas como poner un Jeeves."

L["Racial: "] = "Racial: "
L["Leader: "] = "Lider: "
L["Personal: "] = "Personal: "


-- BUFF REMINDERS OPTIONS PANEL-->>GENERAL LOCALISATIONS
L["Reminder Options"] = "Opciones de recordatorio"
L.Reminder_Options = "Opciones para recordar cuando ciertos beneficios faltan."
L.Disabled_Reminder_Options = "|cffFF0000Este modulo esta deshabilitado.|r Para activarlo, activa \"|cff00CCFFActivar modulo de Recordatorio de Beneficios|r\" en la ventana principal de opciones."
L.Spell_To_Check = "Nombre del hechizo que quieres comprobar:"
L.Spell_To_Check_Desc = "Introduce el nombre del hechizo que quieres que se te recuerde. |cffFF0000ATENCION:|r Si no introduces el nombre del hechizo de forma precisa, no funcionara."
L["Disable in PvP"] = "Desactivar en JcJ" -- To Be Removed and replaced with the earlier "Enable in PvP". I need to rework the Reminders module a little first though.
L["Turns off the spell reminders while you have PvP active."] = "Desactiva los recordatorios de hechizos mientras tienes el JcJ activado." -- Will need to be changed soon also.
L.Enable_In_Spec1 = "Activar en Especializacion Primaria"
L.Enable_In_Spec1_Desc = "Activa el recordatorio de buffs faltantes si estas en tu Especializacion Primaria"
L.Enable_In_Spec2 = "Activar en Especializacion Secundaria"
L.Enable_In_Spec2_Desc = "Activa el recordatorio de buffs faltantes si estas en tu Especializacion Secundaria"
L["Remind Interval"] = "Intervalo de recordatorio"
L.Remind_Interval_Desc = "Cada cuanto quieres que se te recuerden los beneficios faltantes."
L["Announce In"] = "Anunciar en"
L["Chat Window"] = "Ventana de chat" -- REMOVE. Buff Reminders will use LibSink soon, this will be redundant.
L["Sends reminders to your default chat window."] = "Envia recordatorios a tu ventana de chat por defecto." -- This too.
L["Raid Warning Frame"] = "Marco de Advertencia de Banda" -- And this.
L["Sends reminders to your Raid Warning frame at the center of the screen."] = "Envia recordatorios a tu marco de Advertencia de Banda en el centro de la pantalla." -- And also this.


-- SPELL OPTIONS PANEL-->>GENERAL LOCALISATIONS
L["Spell Options"] = "Opciones de hechizos"
L.Spell_Options = "Opciones para hechizos individuales. Selecciona el hechizo que quieres configurar de la lista de la derecha."

L["Hostile Only"] = "Solo Hostil"
L.Hostile_Only_Desc = "Anuncia solo si el objetivo es atacable"


-- SPELL OPTIONS PANEL-->>CHANNEL OPTIONS
L["Local"] = "Local"
L.Local_Desc = "Si esta seleccionado, anuncia en el area de tu eleccion, esto es especificado en el panel de opciones principal en la seccion \"Area de salida del mensaje Local\".\nEsta opcion no sigue las opciones de anuncio globales, y si esta activada anunciara sin importar esas opciones."

L["Whisper"] = "Susurrar"
L.Whisper_Desc = "Susurra al objetivo del hechizo.\nEsta opcion no sigue las opciones de anuncio globales, y si esta activada anunciara sin importar esas opciones."

L["Custom Channel"] = "Canal personalizado"
L.Custom_Channel_Desc = "Esto es |cffFF0000SOLO|r para canales creados por jugadores. Por ejemplo: \"CanaldelSanadordeHermandad\"\nHay una opcion en las opciones pricipales que afecta a si esto puede anunciar mientras estas en grupo o no."

L["Channel Name"] = "Nombre del canal"
L.Channel_Name_Desc = "Introduce el nombre del canal al que quieres enviar los annuncios. Por favor |cffFF0000SOLO|r usa canales creados por jugadores. Canales que ya existen, como \"Grupo\" |cffFF0000NO|r funcionaran."

L["Raid"] = "Banda"
L.Raid_Desc = "Anuncia al canal de Banda, si estas en una banda. No funciona para Campos de Batalla ni Arenas."

L["Party"] = "Grupo"
L.Party_Desc = "Anuncia al canal de Grupo, si estas en un grupo o banda. No funciona en Campos de Batalla."

L["Smart Group"] = "Grupo Inteligente"
L.Smart_Group_Desc = "Envia a Banda si estas en una banda, o a Grupo si estas en un grupo. Tamben envia al canal de Campo de Batalla si estas en un Campo de Batalla o Arena."

L["Say"] = "Decir"
L.Say_Desc = "Anuncia al canal Decir.\nHay una opcion en las opciones principales que afecta a si esto puede anunciar mientras estas en un grupo o no."

L.Yell = true
L.Yell_Desc = "Announces to the Yell channel."


-- SPELL OPTIONS PANEL-->>MESSAGE OPTIONS
L["Message Settings"] = "Opciones de mensaje"
L.Message_Settings_Desc = "Aqui puedes personalizar los mensajes que son enviados cuando anuncias este hechizo. Para deshabilitar cierto anuncio, dejalo en blanco. Puedes poner cualquiera de las siguientes claves en tus mensajes para hacerlos mas dinamicos:\n|cFFFF75B3%%|r para un simbolo %.\n|cFFFF75B3[SPELL]|r para el nombre del hechizo.\n|cFFFF75B3[LINK]|r para un enlace clickable."
L.MST = "\n|cFFFF75B3[TARGET]|r para el nombre del objetivo."
L.MSA = "\n|cFFFF75B3[AMOUNT]|r para la cantidad de daño hanado/hecho/recibido."
L.MSM = "\n|cFFFF75B3[MISSTYPE]|r para el tipo de resistencia."
L.MSI = "\n|cFFFF75B3[TARSPELL]|r para el nombre del hechizo del objetivo.\n|cFFFF75B3[TARLINK]|r para un enlace clickable del hechizo del objetivo."
L.MSB = "\n|cFFFF75B3[AURA]|r para el nombre del perjuicio eliminado.\n|cFFFF75B3[AURALINK]|r para un enlace clickable del perjuicio eliminado."
L.MSS = "\n|cFFFF75B3[STAGGER]|r para un enlace clickable de Aplazar.\n|cFFFF75B3[AMOUNT]|r para la cantidad de daño eliminada."

-- SPELL OPTIONS PANEL-->>MISCELLANEOUS TRANSLATIONS
L["Dispel"] = true

-- Amount minimums
L["Minimum"] = "Minimo"
L.MinimumNeeded = "Cantidad minima necesaria para anunciar."

-- Grounding Totem Descriptions
L["Destroyed by damage"] = "Destruido por daño"
L.DestroyedByDamage = "El mensaje mostrado cuando tu totem es destruido por daño."

L["Destroyed by other effects"] = "Destruido por otros efectos"
L.DestroyedByOther = "El mensaje mostrado cuando tu totem es destruido por efectos que no hacen daño, como " .. GetSpellInfo(118) .. "."


-- Load on Demand Descriptions
L.OptionsDisabled = "Modulo desactivado, por favor activalo."
L.OptionsMissing = "El modulo no pudo ser encontrado, por favor elimina tus carpetas RSA, descarga e instalalo de nuevo."
L.OptionsClass = " Si quieres usar RSA con esta clase, por favor activa el modulo."
-- Option Titles
L["Enabling Options"] = "Activando Opciones"
L["End"] = "Final"
L["Help!"] = "Ayuda!"
L["Reminder Spell"] = "Hechizo recordatorio"
L["Resisted"] = "Resistido"
L["Start"] = "Comienzo"
L["Successful"] = "Exitoso"
L["Heal"] = "Sanacion"
L["Upon Placement"] = "Al colocar"
L["When Tripped"] = ""
L["Interrupt"] = "Interrumpir"
L["Aura Applied"] = "Aura aplicada"
L["Stolen Charges"] = "Cargas robadas"
-- Option Descriptions
L.DescSpellStartSuccess = "El mensaje mostrado cuando el hechizo es lanzado con exito."
L.DescTrapPlacement = "El mensaje mostrado cuando tu trampa es lanzada."
L.DescTrapTripped = "El mensaje mostrado cuando tu trampa es activada."
L.DescSpellStartCastingMessage = "El mensaje mostrado al lanzar el hechizo, a al aplicarse el perjuicio."
L.DescSpellEndCastingMessage = "El mensaje mostrado al terminar el hechizo, o cuando el perjuicio es eliminado."
L.DescSpellEndResist = "El mensaje mostrado cuando el hechizo es resistido."
L.DescSpellEndImmune = "El mensaje mostrado cuando el objetivo es inmune."
L.DescSpellProcName = "El mensaje mostrado cuando el hechizo actua."
L.DescLightwellRenewStolen = "El mensaje mostrado cuando alguien hace click en el Pozo de Luz demasiado rapido y usa multiples cargas."
-- Onload Messages
L.alpha_message = "|cffFF0000ATENCION:|r Estas usando una version Alpha de RSA. Puede que no funcione como se espera!"
L.updated_message = "|cffFF0000Warning:|r Algunas opciones han cambiado en RSA."
