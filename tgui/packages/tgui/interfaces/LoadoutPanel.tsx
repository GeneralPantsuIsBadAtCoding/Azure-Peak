import { useState } from 'react';
import { useBackend } from 'tgui/backend';
import { Window } from 'tgui/layouts';
import { DmIcon, Button, Icon, Box, ProgressBar, Stack, Tabs, Input } from 'tgui-core/components';

interface Data {
  categories: Category[];
  isDonator: number;
  curLoadoutSlots: number;
  maxLoadoutSlots: number;
}

interface Category {
  Items: Item[];
}

interface Item {
  name: string;
  path: string;
  isDonatorItem: boolean;
  icon: string;
  icon_state: string;
  isSelected: boolean;
}

export const LoadoutPanel = (props) => {
  const { data, act } = useBackend<Data>();
  const [tabIndex, setTabIndex] = useState(0);
  const [searchQuery, setSearchQuery] = useState('');
  const [confirmReset, setConfirmReset] = useState(false);

  const categoriesArray = Object.entries(data.categories ?? {}).map(([name, items]) => ({
    name,
    items,
  }));

  const fallback = (
    <Icon m='32px' name="spinner" spin />
  );

  const easter = [
    'Сделано Авфулом',
    'Внимание!!! ПСАЙДОН СДОХ',
    'АБЫРВАЛГ',
    'Нок сила!',
    'Нок и Зизо подружки лесбушки',
    'Нажмешь на кнопку еще раз и я зафоршу тебе расу на кошкодевку',
                                                                                                                                                                                                                      '\u0421\u043c\u0430\u0439\u043b\u0438\u0020\u043b\u043e\u0448\u0430\u0440\u0430',
                                                                                                                                                                                                                      '\u0420\u0435\u0434\u043c\u0443\u043d\u0020\u0438\u0020\u0431\u043b\u044e\u043c\u0443\u043d\u0020\u0433\u043e\u0432\u043d\u043e',
                                                                                                                                                                                                                      '\u0411\u041b\u042f\u0020\u042f\u0020\u041d\u0415\u041d\u0410\u0412\u0418\u0416\u0423\u0020\u0424\u0423\u0420\u0420\u0418',
  ];

  const [authored, setAuthored] = useState(easter[0]);

  const filteredItems = Object.values(categoriesArray[tabIndex]?.items || {}).filter(item =>
    (item?.name?.toLowerCase() || '').includes(searchQuery.toLowerCase())
  );

  const handleResetClick = () => {
    if (confirmReset) {
      act('clear', {});
      setTimeout(() => setConfirmReset(false), 100);
    } else {
      setConfirmReset(true);
      setTimeout(() => setConfirmReset(false), 5000);
    }
  };

  return (
    <Window title={"Лодаут"} width={1000} height={700}>
      <Window.Content>
        <Box style={{ position: 'absolute', width: '300px', height: '200px' }}>
          <Box style={{
            position: 'absolute',
            top: '0',
            userSelect: 'none',
            left: '0',
            fontSize: '12px',
            fontWeight: 'bold',
            padding: '4px',
          }}
            onClick={() => setAuthored(easter[Math.floor(Math.random() * easter.length)])}
          >
            {authored}
          </Box>
        </Box>
        <Stack vertical fill textAlign="center">
          <Stack.Item>
            <h2>Выберите предметы для вашего персонажа.</h2>
          </Stack.Item>
          <Stack.Item>
            <h2>Вы их сможете забрать, когда нажмете правой кнопкой мыши по статуе или дереву.</h2>
          </Stack.Item>
          <Stack.Item>
            <h4>Рескины на оружие(Donator kit) являются просто рескинами, чтобы его получить используйте зелье на соответствующем предмете.</h4>
          </Stack.Item>
          <Stack.Item>
            <Button onClick={() => act('boosty')}>
              <h3>Поддержать сервер</h3>
            </Button>
          </Stack.Item>
          <br />
          <Stack.Item>
            {data.curLoadoutSlots} / {data.maxLoadoutSlots}
          </Stack.Item>
          <Stack.Item>
            <ProgressBar
              ranges={{
                bad: [0.75, Infinity],
                average: [0.25, 0.75],
                good: [-Infinity, 0.25],
              }}
              value={data.curLoadoutSlots / data.maxLoadoutSlots}
              width="300px"
            />
          </Stack.Item>
          <Stack.Item
            style={{
              display: 'flex',
              justifyContent: 'space-between',
              alignItems: 'center',
              marginTop: '10px',
            }}
          >
            <Input
              placeholder="Поиск предметов..."
              value={searchQuery}
              onChange={setSearchQuery}
              width="300px"
            />
            <Button 
              onClick={handleResetClick}
              style={{ marginTop: '10px' }} 
              color={confirmReset ? 'good' : 'danger'}
            >
              <span style={{ color: 'white' }}>
                {confirmReset ? 'Точно?' : 'Сбросить все'}
              </span>
            </Button>
          </Stack.Item>          
          <Stack.Item>
            <Tabs>
              {categoriesArray.map((cat, i) => (
                <Tabs.Tab
                  key={i}
                  selected={i === tabIndex}
                  onClick={() => setTabIndex(i)}
                  style={{
                    flex: 1,
                    backgroundColor: i === tabIndex ? "#444" : "#222",
                    color: "white",
                  }}
                >
                  {cat.name}
                </Tabs.Tab>
              ))}
            </Tabs>
          </Stack.Item>
          <Stack.Item
            style={{
              overflow: 'auto',
            }}
          >
            {filteredItems.map((item, index) => (
              <div
                key={item?.name || item?.path || index}
                style={{
                  display: 'flex',
                  alignItems: 'center',
                  padding: '8px',
                  minHeight: '64px',
                  backgroundColor: index % 2 === 0 ? '#2e2e2e' : '#1c1c1c',
                  borderRadius: '4px',
                  marginBottom: '4px',
                }}
              >
                <DmIcon
                  icon={item?.icon}
                  fallback={fallback}
                  icon_state={item?.icon_state}
                  style={{
                    backgroundColor: '#141414',
                    borderRadius: '12px',
                    padding: '16px',
                    width: '96px',
                    height: '96px',
                  }}
                />
                <blockquote style={{ margin: 0, flexGrow: 1, fontSize: '18px', color: '#e4e4e4', textShadow: "2px 2px 4px rgba(0,0,0,0.5)" }}>{item?.name || 'Без названия'}</blockquote>
                <Box
                  style={{
                    width: 96,
                    height: 96,
                    backgroundColor: (item?.isDonatorItem && data.isDonator === 0) ? "#a75818ff" : item?.isSelected ? "#a71818" : "#24a718",
                    borderRadius: 8,
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center",
                    color: '#000',
                  }}
                  onClick={() => {
                    if (item?.isDonatorItem && data.isDonator === 0) {
                      return;
                    }

                    if (item?.isSelected) {
                      act('remove', { item: item?.name || item?.path });
                    } else {
                      act('add', { item: item?.name || item?.path });
                    }
                  }}
                >
                  <b>{(item?.isDonatorItem && data.isDonator === 0) ? 'Недоступно' : item?.isSelected ? 'Убрать' : 'Взять'}</b>
                </Box>
              </div>
            ))}
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
