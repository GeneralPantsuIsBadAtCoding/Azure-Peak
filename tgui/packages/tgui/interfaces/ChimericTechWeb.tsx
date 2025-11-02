import { Dispatch, SetStateAction, useState } from 'react';
import {
  Box,
  Button,
  Input,
  NoticeBox,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type TechNode = {
  name: string;
  desc: string;
  cost: number;
  path: string;
  required_tier: number;
  can_afford: boolean;
};

type Data = {
  choices: TechNode[];
  points: number;
  tier: number;
};

// Reusable search bar component
export const SearchBar = (props: {
  search: string;
  setSearch: Dispatch<SetStateAction<string>>;
}) => {
  const { search, setSearch } = props;
  return <Input value={search} onChange={setSearch} fluid />;
};


export const ChimericTechWeb = (props) => {
  const [search, setSearch] = useState('');
  const { act, data } = useBackend<Data>();

  const { choices = [], points, tier } = data;

  // We only filter by search text here. Eligibility is handled by DM/SS.
  const filteredChoices = (Array.isArray(choices) ? choices : [])
  /*
    .filter((node) => {
      if (search) {
        return node.name.toLowerCase().includes(search.toLowerCase());
      }
      return true;
    })*/
    .sort(
      // Sort by affordability, then tier, then name
      (a, b) => 
        (b.can_afford as any) - (a.can_afford as any) ||
        a.required_tier - b.required_tier ||
        a.name.localeCompare(b.name),
    );

  return (
    <Window width={600} height={500} title="Chimeric Tech Web">
      <Window.Content>
        <Section title="Current Status">
          <Stack>
            <Stack.Item grow>
                <Box bold color="label">Tech Points:</Box> {points}
            </Stack.Item>
            <Stack.Item grow>
                <Box bold color="label">Language Tier:</Box> {tier}
            </Stack.Item>
          </Stack>
        </Section>

        <Section
          title="Available Research"
          fill
          scrollable
          buttons={<SearchBar search={search} setSearch={setSearch} />}
        >
          {filteredChoices.length === 0 && (
            <NoticeBox>
                No new research is currently available. 
                You may need more Tech Points, a higher Language Tier, or you may be missing a prerequisite for all remaining nodes.
            </NoticeBox>
          )}

          {filteredChoices.map((node) => (
            <Box key={node.path} mb={1}>
              <Stack align="center" justify="space-between">
                <Stack.Item grow>
                  <Box bold>{node.name}</Box>
                  <Box color="label">Tier {node.required_tier} | Cost {node.cost}</Box>
                  <Box className="text-desc">{node.desc}</Box>
                </Stack.Item>

                <Stack.Item>
                  <Button
                    icon="gear"
                    color={node.can_afford ? 'good' : 'bad'}
                    disabled={!node.can_afford}
                    onClick={() => act('unlock_node', { path: node.path })}
                  >
                    {node.can_afford ? 'Unlock' : 'Too Expensive'}
                  </Button>
                </Stack.Item>
              </Stack>
            </Box>
          ))}
        </Section>
      </Window.Content>
    </Window>
  );
};
