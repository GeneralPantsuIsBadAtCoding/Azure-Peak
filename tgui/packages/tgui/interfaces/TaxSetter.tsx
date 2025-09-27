import {
  Button,
  LabeledList,
  NumberInput,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend, useLocalState } from '../backend';
import { Window } from '../layouts';

interface Data {
  nobleTax: number;
  nobleFine: boolean;
  churchTax: number;
  churchFine: boolean;
  yeomenTax: number;
  yeomenFine: boolean;
  peasantTax: number;
  peasantFine: boolean;
}

export const TaxSetter = (props: any, context: any) => {
  const { act, data } = useBackend<Data>();

  const [nobleTax, setnobleTax] = useLocalState('nobleTax', data.nobleTax);
  const [nobleFine, setnobleFine] = useLocalState('nobleFine', data.nobleFine);
  const [churchTax, setchurchTax] = useLocalState('churchTax', data.churchTax);
  const [churchFine, setchurchFine] = useLocalState(
    'churchFine',
    data.churchFine,
  );
  const [yeomenTax, setyeomenTax] = useLocalState('yeomenTax', data.yeomenTax);
  const [yeomenFine, setyeomenFine] = useLocalState(
    'yeomenFine',
    data.yeomenFine,
  );
  const [peasantTax, setPeasantTax] = useLocalState(
    'peasantTax',
    data.peasantTax,
  );
  const [peasantFine, setpeasantFine] = useLocalState(
    'peasantFine',
    data.peasantFine,
  );

  return (
    <Window width={530} height={300}>
      <Window.Content>
        <Stack vertical>
          <Stack.Item>
            <Stack>
              <Stack.Item>
                <TaxBlock
                  title={'Noble tax'}
                  taxAmount={nobleTax}
                  fineExempt={nobleFine}
                  onTaxChange={(value) => setnobleTax(value)}
                  onFineChange={() => setnobleFine(!nobleFine)}
                />
                <TaxBlock
                  title={'Church tax'}
                  taxAmount={churchTax}
                  fineExempt={churchFine}
                  onTaxChange={(value) => setchurchTax(value)}
                  onFineChange={() => setchurchFine(!churchFine)}
                />
              </Stack.Item>
              <Stack.Item>
                <TaxBlock
                  title={'Yeomen tax'}
                  taxAmount={yeomenTax}
                  fineExempt={yeomenFine}
                  onTaxChange={(value) => setyeomenTax(value)}
                  onFineChange={() => setyeomenFine(!yeomenFine)}
                />
                <TaxBlock
                  title={'Peasant tax'}
                  taxAmount={peasantTax}
                  fineExempt={peasantFine}
                  onTaxChange={(value) => setPeasantTax(value)}
                  onFineChange={() => setpeasantFine(!peasantFine)}
                />
              </Stack.Item>
            </Stack>
          </Stack.Item>
          <Stack.Item>
            <Button.Confirm
              fluid
              color="good"
              textAlign="Center"
              onClick={() =>
                act('set_taxes', {
                  nobleTax: nobleTax,
                  nobleFine: nobleFine,
                  yeomenTax: yeomenTax,
                  yeomenFine: yeomenFine,
                  churchTax: churchTax,
                  churchFine: churchFine,
                  peasantTax: peasantTax,
                  peasantFine: peasantFine,
                })
              }
            >
              MAKE IT SO
            </Button.Confirm>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

interface TaxBlockProps {
  title: string;
  taxAmount: number;
  fineExempt: boolean;
  onTaxChange: (action: number) => void;
  onFineChange: (action: boolean) => void;
}

export const TaxBlock = (props: TaxBlockProps) => {
  const { title, taxAmount, fineExempt, onTaxChange, onFineChange } = props;

  return (
    <Section title={title}>
      <LabeledList>
        <LabeledList.Item label={<b>Tithe</b>}>
          <NumberInput
            step={1}
            minValue={0}
            maxValue={100}
            value={taxAmount}
            onChange={(value: number) => onTaxChange(value)}
          />
        </LabeledList.Item>
        <LabeledList.Item label={<b>Fine exemption</b>}>
          <Button
            content={fineExempt ? 'by my mercy' : 'they shall pay'}
            color={fineExempt ? 'bad' : 'good'}
            onClick={() => onFineChange(!fineExempt)}
          />
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
