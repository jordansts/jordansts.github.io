module AreaSetorCircular exposing (..)
import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

areaSetorCircular : String -> String -> String
areaSetorCircular r a =
  case (String.toFloat r, String.toFloat a) of
    (Just n, Just m) ->
      if n > 0 then String.fromFloat(abs((( pi * n^2) * m)/360)) ++ " u²"
      else "Indeterminado"
    _ -> "Indeterminado"

-- MAIN 
-- O programa principal é uma função chamada sandbox em que você passa um Record de ELM contendo três elementos: init (que é o modelo incial), update (função de atualização de valores do modelo) e view (função para visualização no Browser)
type alias Model = {i1 : String, i2 : String}
type Msg = Input1 String | Input2 String

main =
  Browser.sandbox
  {
    init = Model "" "",
    update = update,
    view = view
  }

-- UPDATE
-- Agora que temos um modelo, precisamos definir como ele muda com o tempo. É uma prática interessante sempre iniciar a seção de UPDATE do código, definindo um conjunto de mensagens que serão recebidas da interface do usuário: mensagem de incremento ou de decremento, neste exemplo.
update : Msg -> Model -> Model
update msg model =
  case msg of
    Input1 n -> {model | i1 = n}
    Input2 m -> {model | i2 = m}
  
-- VIEW
-- Neste trecho, ocorre a visualização do modelo para o usuário em HTML. A biblioteca html dá acesso total ao HTML5 como funções normais do Elm. A função view está produzindo um valor Html Msg. Os atributos onClick estão definidos para dar valores de Incremento e Decremento; eles serão alimentados diretamente na função de atualização, levando todo o aplicativo adiante.
view : Model -> Html Msg
view model =
  let
    toText = {output = areaSetorCircular model.i1 model.i2, title = "Calcular Área da Setor Circular", box1 = "Raio", box2 = "Ângulo"}
  in
    div [ class "card col-md-4 bg-dark" ]
        [ div [ class "card-body bg-dark text-light" ]
            [ h5 [ class "card-title" ] [ text toText.title ]
            , div []
                [ div [ class "row" ]
                    [ div [ class "col-md-6" ] [ input [ class "form-control bg-dark text-light", placeholder toText.box1, type_ "number", onInput Input1 ] [] ]
                    , div [ class "col-md-6" ] [ input [ class "form-control bg-dark text-light", placeholder toText.box2, type_ "number", onInput Input2 ] [] ]
                    ]
                , div [ class "row" ] [ div [ class "col-md-12" ] [ span [ class "h6" ] [ text "Resultado: " ], text toText.output ] ]
                ]
            ]
        ]
        