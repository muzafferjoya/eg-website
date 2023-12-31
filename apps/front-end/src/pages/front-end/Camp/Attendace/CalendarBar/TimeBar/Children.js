// Lib
import * as React from "react";
import { H2, Caption } from "@shiksha/common-lib";
import { useTranslation } from "react-i18next";
import { VStack } from "native-base";
import moment from "moment";
import { FormatDate } from "../FormatDate";

export const Children = ({ type, date, page }) => {
  const { t } = useTranslation();
  switch (true) {
    case type === "monthInDays":
      return (
        <VStack>
          <FormatDate date={date} type="Month" />
          {/* <Text fontSize="10" fontWeight="300">
			{t("THIS_MONTH")}
		  </Text> */}
        </VStack>
      );
    case type === "week":
      return (
        <VStack alignItems="center">
          <H2>
            <FormatDate date={date} type="Week" />
          </H2>
          <Caption>{t("THIS_WEEK")}</Caption>
        </VStack>
      );
    default:
      return (
        <VStack>
          <H2>
            {page === 0
              ? t("TODAY")
              : page === 1
              ? t("TOMORROW")
              : page === -1
              ? t("YESTERDAY")
              : // @ts-ignore
                moment(date).format("dddd")}
          </H2>
          <Caption>
            <FormatDate date={date} />
          </Caption>
        </VStack>
      );
  }
};
