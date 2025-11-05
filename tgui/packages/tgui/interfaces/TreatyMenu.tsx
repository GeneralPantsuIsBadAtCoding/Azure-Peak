import { Section, Stack } from 'tgui-core/components';

import { Window } from '../layouts';

export const TreatyMenu = (props) => {
  return (
    <Window theme="azure_treaty" width={800} height={62}>
      <Window.Content>
        <Stack vertical>

          <Section title="FIRST PARTY" />

          <Section title="SECOND PARTY" />

          <Section title="TERMS" />
        </Stack>
      </Window.Content>
    </Window>
  );
};
