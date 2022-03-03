import {
  InstrumentCreated,
  SetPurpose
} from "../generated/YourContract/YourContract";
import { Instrument } from '../generated/schema'

export function handleSetPurpose(event: SetPurpose): void {

}

export function handleInstrumentCreated(event: InstrumentCreated): void {

  let instrument = new Instrument(event.transaction.hash.toHex() + "-" + event.logIndex.toString())

  instrument.base = event.params.base.toString()
  instrument.quote = event.params.quote.toString()
  instrument.liquiditySource = 'YIELD'
  instrument.maturity = event.params.maturity
  instrument.symbol = event.params.symbol.toString()

  instrument.save()

}
