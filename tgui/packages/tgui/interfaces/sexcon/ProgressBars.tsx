import { Box, ProgressBar, Section, Stack } from 'tgui-core/components';

interface ProgressBarsProps {
  arousal: number;
  pleasure: number;
  pain: number;
}

export const ProgressBars = (props: ProgressBarsProps) => {
  const { arousal, pleasure, pain } = props;

  return (
    <Section>
      <Stack vertical>
        <Stack.Item>
          <Stack>
            <Stack.Item basis="25%">
              <Box bold>Pleasure:</Box>
            </Stack.Item>
            <Stack.Item grow>
              <ProgressBar
                value={pleasure / 100}
                ranges={{
                  good: [0.5, Infinity],
                  average: [0.25, 0.5],
                  bad: [-Infinity, 0.25],
                }}
              />
            </Stack.Item>
          </Stack>
        </Stack.Item>

        <Stack.Item>
          <Stack>
            <Stack.Item basis="25%">
              <Box bold>Arousal:</Box>
            </Stack.Item>
            <Stack.Item grow>
              <ProgressBar
                value={arousal / 100}
                ranges={{
                  good: [0.5, Infinity],
                  average: [0.25, 0.5],
                  bad: [-Infinity, 0.25],
                }}
              />
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
    </Section>
  );
};
