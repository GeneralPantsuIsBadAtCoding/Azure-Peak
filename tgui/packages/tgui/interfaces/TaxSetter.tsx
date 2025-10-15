import {
  Button,
  LabeledList,
  NumberInput,
  Section,
  Stack,
} from 'tgui-core/components';

import { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { useState } from 'react';

import { Window } from '../layouts';

type TaxCategory = {
  categoryName: string;
  taxAmount: number;
  fineExemption: BooleanLike;
}

type Data = {
  taxCategories: TaxCategory[];
}

export const TaxSetter = (props: any, context: any) => {
  const { act, data } = useBackend<Data>();

  const [taxationCats, setTaxationCats] = useState<{
    [cat: string]: TaxCategory;
  }>(() => {
    if (data.taxCategories) {
      return Object.fromEntries(
        data.taxCategories.map((cat) => [cat.categoryName, cat]),
      );
    }
    return {};
  });

  const setTaxCat = (
    newCatName: string,
    newTaxAmount: number,
    newFineExemption: BooleanLike,
  ) => {
    setTaxationCats((prev) => {
      return {
        ...prev,
        [newCatName]: {
          ...prev[newCatName],
          taxAmount: newTaxAmount,
          fineExemption: newFineExemption,
        },
      };
    });
  };

  return (
    <Window width={300} height={535}>
      <Window.Content>
        <Stack vertical>
          <Stack.Item>
            <Stack>
              <Stack.Item>
                {Object.values(taxationCats)?.map((category, i) => (
                  <TaxBlock
                    key={i}
                    title={category.categoryName}
                    taxAmount={category.taxAmount}
                    fineExempt={category.fineExemption}
                    onFineChange={(
                      newCatName: string,
                      newTaxAmount: number,
                      newFineExemption: BooleanLike,
                    ) => setTaxCat(newCatName, newTaxAmount, newFineExemption)}
                    onTaxChange={(
                      newCatName: string,
                      newTaxAmount: number,
                      newFineExemption: BooleanLike,
                    ) => setTaxCat(newCatName, newTaxAmount, newFineExemption)}
                  />
                ))}
              </Stack.Item>
            </Stack>
          </Stack.Item>
          <Stack.Item>
            <Button.Confirm
              fluid
              color="transparent"
              className="input-button__submit"
              textAlign="Center"
              onClick={() => act('set_taxes', { taxationCats })}
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
  fineExempt: BooleanLike;
  onTaxChange: (
    newCatName: string,
    newTaxAmount: number,
    newFineExemption: BooleanLike,
  ) => void;
  onFineChange: (
    newCatName: string,
    newTaxAmount: number,
    newFineExemption: BooleanLike,
  ) => void;
}

export const TaxBlock = (props: TaxBlockProps) => {
  const { title, taxAmount, fineExempt, onTaxChange, onFineChange } = props;

  return (
    <Section title={title}>
      <LabeledList>
        <LabeledList.Item label={<b>Tax</b>}>
          <NumberInput
            step={1}
            minValue={0}
            maxValue={100}
            value={taxAmount}
            onChange={(value: number) => onTaxChange(title, value, fineExempt)}
          />
        </LabeledList.Item>
        <LabeledList.Item label={<b>Fine exemption</b>}>
          <Button
            color="transparent"
            className={fineExempt ? "input-button__submit" : "input-button__cancel"}
            content={fineExempt ? 'by my mercy' : 'they shall pay'}
            onClick={() => onFineChange(title, taxAmount, !fineExempt)}
          />
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
